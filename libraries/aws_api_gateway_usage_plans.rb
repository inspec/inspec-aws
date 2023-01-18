require "aws_backend"

class AWSApiGatewayUsagePlans < AwsCollectionResourceBase
  name "aws_api_gateway_usage_plans"
  desc "Gets all the usage plans of the caller's account."
  example <<-EXAMPLE
    describe aws_api_gateway_usage_plans do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch(client: :apigateway_client, operation: :get_usage_plans).items.map(&:to_h)
    populate_filter_table_from_response
  end
end
