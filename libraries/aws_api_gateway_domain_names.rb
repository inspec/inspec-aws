require 'aws_backend'

class AWSApiGatewayDomainNames < AwsCollectionResourceBase
  name 'aws_api_gateway_domain_names'
  desc 'Represents a collection of DomainName resources.'
  example <<-EXAMPLE
    describe aws_api_gateway_domain_names do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters
    catch_aws_errors do
      @table = fetch(client: :apigateway_client, operation: :get_domain_names).items.map(&:to_h)
      populate_filter_table_from_response
    end
  end
end
