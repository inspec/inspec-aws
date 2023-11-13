require 'aws_backend'

class AWSLambdaAliases < AwsResourceBase
  name 'aws_lambda_aliases'
  desc 'Returns a list of aliases for a Lambda function.'

  example "
    describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:alias_arns, field: :alias_arn)
             .register_column(:names, field: :name)
             .register_column(:function_versions, field: :function_version)
             .register_column(:descriptions, field: :description)
             .register_column(:routing_configs, field: :routing_config)
             .register_column(:revision_ids, field: :revision_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(function_name))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: function_name must be provided" unless opts[:function_name] && !opts[:function_name].empty?
    @query_params[:function_name] = opts[:function_name]
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.lambda_client.list_aliases(@query_params).map do |table|
        table.aliases.map { |table_name| {
          alias_arn: table_name.alias_arn,
          name: table_name.name,
          function_version: table_name.function_version,
          description: table_name.description,
          routing_config: table_name.routing_config,
          revision_id: table_name.revision_id,
        }
        }
      end.flatten
    end
  end
end
