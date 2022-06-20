# frozen_string_literal: true

require 'aws_backend'

class AwsApiGatewayV2Apis < AwsResourceBase
  name 'aws_api_gateway_v2_apis'
  desc 'Gets information about the current ApiKeys resource.'
  example <<-EXAMPLE
    describe aws_api_gateway_v2_apis do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters
    catch_aws_errors do
      @table = fetch(client: :apigatewayv2_client, operation: :get_apis).items.map(&:to_h)
      populate_filter_table_from_response
    end
  end
end
