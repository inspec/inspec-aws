require "aws_backend"

class AWSLambdaCodeSigningConfigs < AwsResourceBase
  name "aws_lambda_code_signing_configs"
  desc "Returns a list of code signing configurations."

  example "
    describe aws_lambda_code_signing_configs do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:code_signing_config_ids, field: :code_signing_config_id)
    .register_column(:code_signing_config_arns, field: :code_signing_config_arn)
    .register_column(:descriptions, field: :description)
    .register_column(:allowed_publishers, field: :allowed_publishers)
    .register_column(:code_signing_policies, field: :code_signing_policies)
    .register_column(:last_modified, field: :last_modified)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.lambda_client.list_code_signing_configs.map do |table|
        table.code_signing_configs.map { |table_name| {
          code_signing_config_id: table_name.code_signing_config_id,
          code_signing_config_arn: table_name.code_signing_config_arn,
          description: table_name.description,
          allowed_publishers: table_name.allowed_publishers,
          code_signing_policies: table_name.code_signing_policies,
          last_modified: table_name.last_modified,
        }
        }
      end.flatten
    end
  end
end
