require "aws_backend"

class AWSSignerSigningProfiles < AwsResourceBase
  name "aws_signer_signing_profiles"
  desc "Returns information on a specific signing profile."

  example "
    describe aws_signer_signing_profiles do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:profile_names, field: :profile_name)
    .register_column(:profile_versions, field: :profile_version)
    .register_column(:profile_version_arns, field: :profile_version_arn)
    .register_column(:signing_materials, field: :signing_material)
    .register_column(:signature_validity_periods, field: :signature_validity_period)
    .register_column(:platform_ids, field: :platform_id)
    .register_column(:platform_display_names, field: :platform_display_name)
    .register_column(:signing_parameters, field: :signing_parameters)
    .register_column(:statuses, field: :status)
    .register_column(:arns, field: :arn)
    .register_column(:tags, field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.signer_client.list_signing_profiles.map do |table|
        table.profiles.map { |table_name| {
          profile_name: table_name.profile_name,
          profile_version: table_name.profile_version,
          profile_version_arn: table_name.profile_version_arn,
          signing_material: table_name.signing_material,
          signature_validity_period: table_name.signature_validity_period,
          platform_id: table_name.platform_id,
          platform_display_name: table_name.platform_display_name,
          signing_parameters: table_name.signing_parameters,
          status: table_name.status,
          arn: table_name.arn,
          tags: table_name.tags,
        }
        }
      end.flatten
    end
  end
end
