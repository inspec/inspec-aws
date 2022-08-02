# frozen_string_literal: true

require 'aws_backend'

class AwsApiGatewayV2Authorizers < AwsCollectionResourceBase
  name 'aws_api_gateway_v2_authorizers'
  desc 'Gets the Authorizers for an API.'
  example <<-EXAMPLE
    describe aws_api_gateway_v2_authorizers(api_id: 'APP_ID') do
      it { should exist }
      its('count') { should >= 1 }
      its('names') { should include 'AUTHORIZER_NAME' }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    catch_aws_errors do
      @table = fetch(client: :apigatewayv2_client, operation: :get_authorizers, kwargs: { api_id: opts[:api_id] }).items.map(&:to_h)
      populate_filter_table_from_response
    end
  end
end
