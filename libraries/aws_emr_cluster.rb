# frozen_string_literal: true

require 'aws_backend'
require 'json'

class AwsEmrCluster < AwsResourceBase
  name 'aws_emr_cluster'
  desc 'Verifies settings for an EMR cluster.'

  example "
    describe aws_emr_cluster('CLUSTER_ID') do
      it { should exist }
      it { should be_running }
      it { should be_waiting }
      its('encryption_at_rest') { should eq true }
      its('encryption_in_transit') { should eq true }
      its('local_disk_encryption') { should eq true }
      its('applications') { should include 'Spark' }
    end
  "
  attr_reader :cluster_id, :cluster_arn, :cluster_name, :status_state, :status_state_change_reason_code,
              :status_state_change_reason_message, :status_timeline_creation_date_time, :status_timeline_ready_date_time,
              :status_timeline_end_date_time, :security_configuration_name,
              :application_names, :auto_scaling_role, :custom_ami_id, :ebs_root_volume_size,
              :kerberos_attributes_realm, :kerberos_attributes_realm_ad_domain_join_user,
              :log_encryption_kms_key_id, :log_uri, :release_label, :scale_down_behavior,
              :service_role, :step_concurrency_level, :visible_to_all_users, :managed_scaling_policy_unit_type

  def initialize(opts = {})
    opts = { cluster_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(cluster_id))
    catch_aws_errors do
      # If no params are passed we attempt to get the 'default' cluster.
      req_cluster_id = opts.nil? ? {} : { cluster_id: opts[:cluster_id] }
      cluster = @aws.emr_client.describe_cluster(req_cluster_id).cluster

      return if !cluster || cluster.empty?

      @status_state = cluster.status.state
      if !cluster.status.state_change_reason.nil?
        @status_state_change_reason_code = cluster.status.state_change_reason.code
        @status_state_change_reason_message = cluster.status.state_change_reason.message
      end
      if !cluster.status.timeline.nil?
        @status_timeline_creation_date_time = cluster.status.timeline.creation_date_time
        @status_timeline_ready_date_time = cluster.status.timeline.ready_date_time
        @status_timeline_end_date_time = cluster.status.timeline.end_date_time
      end
      @cluster_arn = cluster.cluster_arn
      @cluster_name = cluster.name
      @cluster_id = cluster.id
      @application_names = []
      cluster.applications&.each do |application|
        @application_names << application.name
      end
      @auto_scaling_role = cluster.auto_scaling_role
      @custom_ami_id = cluster.custom_ami_id
      @ebs_root_volume_size = cluster.ebs_root_volume_size
      if !cluster.kerberos_attributes.nil?
        @kerberos_attributes_realm = cluster.kerberos_attributes.realm
        @kerberos_attributes_realm_ad_domain_join_user = cluster.kerberos_attributes.ad_domain_join_user
      end
      @log_encryption_kms_key_id = cluster.log_encryption_kms_key_id
      @log_uri = cluster.log_uri
      @release_label = cluster.release_label
      @scale_down_behavior = cluster.scale_down_behavior
      @service_role = cluster.service_role
      @step_concurrency_level = cluster.step_concurrency_level
      @visible_to_all_users = cluster.visible_to_all_users
      @security_configuration_name = cluster.security_configuration
    end
  end

  def exists?
    !@cluster_arn.nil?
  end

  def running?
    !@status_state.nil? && @status_state == 'RUNNING'
  end

  def waiting?
    !@status_state.nil? && @status_state == 'WAITING'
  end

  def resource_id
    @cluster_id
  end

  def to_s
    "AWS EMR Cluster Name: #{@cluster_name}"
  end
end
