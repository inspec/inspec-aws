# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayVPCLinks < AwsCollectionResourceBase
  name 'aws_api_gateway_vpc_links'
  desc 'Gets the VpcLinks collection under the callers account in a selected region.'
  example "
    describe aws_api_gateway_vpc_links do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch(client: :apigateway_client, operation: :get_vpc_links).items.map(&:to_h)
    populate_filter_table_from_response
  end
end
