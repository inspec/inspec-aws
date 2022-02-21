# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayModels < AwsResourceBase
  name 'aws_api_gateway_models'
  desc 'Lists all the API Gateway models.'

  example "
    describe aws_api_gateway_models(api_id: API_ID) do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:content_types, field: :content_type)
             .register_column(:descriptions, field: :description)
             .register_column(:model_ids, field: :model_id)
             .register_column(:names, field: :name)
             .register_column(:schemas, field: :schema)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(api_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.apigateway_client.get_models(api_id: opts[:api_id]).map do |table|
        table.items.map { |table_name| {
          content_type: table_name.content_type,
          description: table_name.description,
          model_id: table_name.model_id,
          name: table_name.name,
          schema: table_name.schema,
        }
        }
      end.flatten
    end
  end
end
