require 'aws_backend'

class AWSApiGatewayResponses < AwsResourceBase
  name 'aws_api_gateway_responses'
  desc 'Retrieves API Gateway Responses.'
  example <<-EXAMPLE
    describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:response_types, field: :response_type)
             .register_column(:status_codes, field: :status_code)
             .register_column(:response_parameters, field: :response_parameters)
             .register_column(:response_templates, field: :response_templates)
             .register_column(:default_responses, field: :default_response)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.apigateway_client.get_gateway_responses(rest_api_id: opts[:rest_api_id]).map do |table|
        table.items.map { |table_name| {
          response_type: table_name.response_type,
          status_code: table_name.status_code,
          response_parameters: table_name.response_parameters['String'],
          response_templates: table_name.response_templates['String'],
          default_response: table_name.default_response,
        }
        }
      end.flatten
    end
  end
end
