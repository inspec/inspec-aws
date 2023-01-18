require "aws_backend"

class AwsApiGatewayV2DomainNames < AwsCollectionResourceBase
  name "aws_api_gateway_v2_domain_names"
  desc "Gets the domain names for an AWS account."
  example <<-EXAMPLE
    describe aws_api_gateway_v2_domain_names do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters
    catch_aws_errors do
      @table = fetch(client: :apigatewayv2_client, operation: :get_domain_names).items.map(&:to_h)
      populate_filter_table_from_response
    end
  end
end
