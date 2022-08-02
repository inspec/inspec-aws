# frozen_string_literal: true

require 'aws_backend'

class AwsApiGatewayV2Routes < AwsCollectionResourceBase
  name 'aws_api_gateway_v2_routes'
  desc 'Gets the Routes for an API.'
  example <<-EXAMPLE
    describe aws_api_gateway_v2_routes(api_id: 'APP_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    catch_aws_errors do
      @table = fetch(client: :apigatewayv2_client, operation: :get_routes, kwargs: { api_id: opts[:api_id] }).items.map(&:to_h)
      populate_filter_table_from_response
    end
  end
end
