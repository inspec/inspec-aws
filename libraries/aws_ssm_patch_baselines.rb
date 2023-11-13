require "aws_backend"

class AWSSESPatchBaselines < AwsResourceBase
  name "aws_ssm_patch_baselines"
  desc "Lists the patch baselines in your Amazon Web Services account."

  example "
    describe aws_ssm_patch_baselines do
      it { should exist }
    end

    describe aws_ssm_patch_baselines do
      its('baseline_ids') { should include BASELINE_ID' }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:baseline_ids, field: :baseline_id)
    .register_column(:baseline_names, field: :baseline_name)
    .register_column(:operating_systems, field: :operating_system)
    .register_column(:baseline_descriptions, field: :baseline_description)
    .register_column(:default_baselines, field: :default_baseline)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.ssm_client.describe_patch_baselines.map do |table|
        table.baseline_identities.map { |table_name| {
          baseline_id: table_name.baseline_id,
          baseline_name: table_name.baseline_name,
          operating_system: table_name.operating_system,
          baseline_description: table_name.baseline_description,
          default_baseline: table_name.default_baseline,
        }
        }
      end.flatten
    end
  end
end
