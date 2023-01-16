require "aws_backend"

class AwsApiGatewayV2IntegrationResponses < AwsCollectionResourceBase
  name "aws_api_gateway_v2_integration_responses"
  desc "Gets the IntegrationResponses for an Integration."
  example <<-EXAMPLE
    describe aws_api_gateway_v2_integration_responses(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts, integration_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id integration_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    raise ArgumentError, "#{@__resource_name__}: integration_id must be provided!" if opts[:integration_id].blank?
    catch_aws_errors do
      @table = fetch(client: :apigatewayv2_client, operation: :get_integration_responses, kwargs: { api_id: opts[:api_id], integration_id: opts[:integration_id] }).items.map(&:to_h)
      populate_filter_table_from_response
    end
  end
end
