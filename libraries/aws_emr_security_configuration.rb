require 'aws_backend'
require 'json'

class AwsEmrClusterSecurityConfiguration < AwsResourceBase
  name 'aws_emr_security_configuration'
  desc 'Verifies security configuration for an EMR cluster.'

  example "
    describe aws_emr_security_configuration('SECURITY_CONFIGURATION_NAME') do
      it { should exist }
      its('encryption_at_rest') { should eq true }
      its('encryption_in_transit') { should eq true }
      its('local_disk_encryption') { should eq true }
    end
  "

  attr_reader :security_configuration_name, :encryption_at_rest, :encryption_in_transit, :local_disk_encryption

  def initialize(opts = {})
    opts = { security_configuration_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(security_configuration_name))
    catch_aws_errors do
      @security_configuration_name = opts[:security_configuration_name]

      resp = @aws.emr_client.describe_security_configuration({ name: @security_configuration_name })
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
    !@security_configuration_name.nil? && !@security_configuration_name.empty?
  end

  def resource_id
    @security_configuration_name
  end

  def to_s
    "AWS EMR Cluster Security Configuration Name: #{@security_configuration_name}"
  end
end
