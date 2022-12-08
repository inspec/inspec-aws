require "aws_backend"

class AWSApiGatewayModels < AwsResourceBase
  name "aws_api_gateway_models"
  desc "Lists all the API Gateway models."

  example "
    describe aws_api_gateway_models(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:content_types, field: :content_type)
    .register_column(:descriptions, field: :description)
    .register_column(:names, field: :name)
    .register_column(:schemas, field: :schema)
    .register_column(:ids, field: :id)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.apigateway_client.get_models(rest_api_id: opts[:rest_api_id]).map do |table|
        table.items.map { |table_name| {
          content_type: table_name.content_type,
          description: table_name.description,
          name: table_name.name,
          schema: table_name.schema,
          id: table_name.id,
        }
        }
      end.flatten
    end
  end
end
