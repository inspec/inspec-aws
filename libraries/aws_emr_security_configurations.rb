require "aws_backend"
require "json"

class AwsEmrClusterSecurityConfigurations < AwsResourceBase
  name "aws_emr_security_configurations"
  desc "Verifies collection of security configuration for an EMR cluster."
  example "
    describe aws_emr_security_configurations do
      it { should exist }
    end
  "
  attr_reader :table

  FilterTable.create
    .register_column(:security_configuration_names, field: :security_configuration_name)
    .register_column(:encryption_at_rests, field: :encryption_at_rest)
    .register_column(:encryption_in_transits, field: :encryption_in_transit)
    .register_column(:local_disk_encryptions, field: :local_disk_encryption)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    security_configuration_rows = []
    pagination_options = {}
    resp_security_configurations = {}
    catch_aws_errors do
      resp_security_configurations = @aws.emr_client.list_security_configurations(pagination_options)
    end

    return security_configuration_rows if !resp_security_configurations || resp_security_configurations.empty?

    resp_security_configurations.security_configurations.each do |s|
      resp_security_configuration = @aws.emr_client.describe_security_configuration({ name: s.name })
      parsed_json = JSON.parse(resp_security_configuration.security_configuration)
      encryption_at_rest = !parsed_json["EncryptionConfiguration"]["EnableAtRestEncryption"].nil? && parsed_json["EncryptionConfiguration"]["EnableAtRestEncryption"]
      encryption_in_transit = !parsed_json["EncryptionConfiguration"]["EnableInTransitEncryption"].nil? && parsed_json["EncryptionConfiguration"]["EnableInTransitEncryption"]
      local_disk_encryption = !parsed_json["EncryptionConfiguration"]["AtRestEncryptionConfiguration"].nil? &&
        !parsed_json["EncryptionConfiguration"]["AtRestEncryptionConfiguration"]["LocalDiskEncryptionConfiguration"].nil? &&
        !parsed_json["EncryptionConfiguration"]["AtRestEncryptionConfiguration"]["LocalDiskEncryptionConfiguration"].empty?

      security_configuration_rows += [{ security_configuration_name:  s.name,
        encryption_at_rest:     encryption_at_rest,
        encryption_in_transit:  encryption_in_transit,
        local_disk_encryption:  local_disk_encryption }]
    end
    @table = security_configuration_rows
  end
end
