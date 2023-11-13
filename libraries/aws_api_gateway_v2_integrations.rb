require "aws_backend"

class AwsApiGatewayV2Integrations < AwsCollectionResourceBase
  name "aws_api_gateway_v2_integrations"
  desc "Gets the Integrations for an API."
  example <<-EXAMPLE
    describe aws_api_gateway_v2_integrations(api_id: 'APP_ID') do
      it { should exist }
      its('integration_ids') { should include 'INTEGRATION_ID' }
      its('connection_ids') { should include 'CONNECTION_ID' }
      its('connection_types') { should include 'INTERNET' }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    catch_aws_errors do
      @table = fetch(client: :apigatewayv2_client, operation: :get_integrations, kwargs: { api_id: opts[:api_id] }).items.map(&:to_h)
      populate_filter_table_from_response
    end
  end
end
