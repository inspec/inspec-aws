require "aws_backend"

class AwsApiGatewayV2Models < AwsCollectionResourceBase
  name "aws_api_gateway_v2_models"
  desc "Gets the Models for an API."
  example <<-EXAMPLE
    describe aws_api_gateway_v2_models(api_id: 'APP_ID') do
      it { should exist }
      its('model_ids') { should eq ['MODEL_ID'] }
      its('names') { should eq ['MODEL_NAME'] }
      its('model_ids') { should include 'MODEL_ID' }
      its('names') { should include 'MODEL_NAME' }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    catch_aws_errors do
      @table = fetch(client: :apigatewayv2_client, operation: :get_models, kwargs: { api_id: opts[:api_id] }).items.map(&:to_h)
      populate_filter_table_from_response
    end
  end
end
