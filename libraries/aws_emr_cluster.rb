# frozen_string_literal: true

require 'aws_backend'
require 'json'

class AwsEmrCluster < AwsResourceBase
  name 'aws_emr_cluster'
  desc 'Verifies settings for an EMR cluster.'

  example "
    describe aws_emr_cluster('CLUSTER_ID') do
      it { should exist }
    end

    describe aws_emr_cluster('CLUSTER_ID') do
      it { should be_running }
    end

    describe aws_emr_cluster('CLUSTER_ID') do
      it { should be_waiting }
    end

    describe aws_emr_cluster('CLUSTER_ID') do
      its('encryption_at_rest') { should eq true }
    end

    describe aws_emr_cluster('CLUSTER_ID') do
      its('encryption_in_transit') { should eq true }
    end

    describe aws_emr_cluster('CLUSTER_ID') do
      its('local_disk_encryption') { should eq true }
    end
  "

  attr_reader :cluster_id, :cluster_arn, :cluster_name, :state,
              :encryption_at_rest, :encryption_in_transit,
              :local_disk_encryption

  def initialize(opts = {})
    opts = { cluster_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(cluster_id name))
    opts[:cluster_id].gsub!('"','')
    catch_aws_errors do
      # If no params are passed we attempt to get the 'default' cluster.
      req_cluster_id = opts.nil? ? {} : { cluster_id: opts[:cluster_id] }
      cluster = @aws.emr_client.describe_cluster(req_cluster_id).cluster

      return if !cluster || cluster.empty?

      @state = cluster.status.state
      @cluster_arn = cluster.cluster_arn
      @cluster_name = cluster.name
      @cluster_id = cluster.id

      return if cluster.security_configuration.nil? || cluster.security_configuration.empty?

      resp = @aws.emr_client.describe_security_configuration({ name: cluster.security_configuration })
      return if resp.nil? || resp.empty?
      json_security_configuration = resp.security_configuration
      return if json_security_configuration.nil? || json_security_configuration.empty?
      parsed_json = JSON.parse(json_security_configuration)
      @encryption_at_rest = !parsed_json['EncryptionConfiguration']['EnableAtRestEncryption'].nil? && parsed_json['EncryptionConfiguration']['EnableAtRestEncryption']
      @encryption_in_transit = !parsed_json['EncryptionConfiguration']['EnableInTransitEncryption'].nil? && parsed_json['EncryptionConfiguration']['EnableInTransitEncryption']
      @local_disk_encryption = !parsed_json['EncryptionConfiguration']['AtRestEncryptionConfiguration'].nil? &&
                               !parsed_json['EncryptionConfiguration']['AtRestEncryptionConfiguration']['LocalDiskEncryptionConfiguration'].nil? &&
                               !parsed_json['EncryptionConfiguration']['AtRestEncryptionConfiguration']['LocalDiskEncryptionConfiguration'].empty?
    end
  end

  def exists?
    !@cluster_arn.nil?
  end

  def running?
    !@state.nil? && @state == 'RUNNING'
  end

  def waiting?
    !@state.nil? && @state == 'WAITING'
  end

  def to_s
    "AWS EMR cluster #{cluster_name}"
  end
end
