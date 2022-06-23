# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayResources < AwsCollectionResourceBase
  name 'aws_api_gateway_resources'
  desc 'Lists information about a collection of Resource resources.'
  example <<-EXAMPLE
    describe aws_api_gateway_resources(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { rest_api_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(rest_api_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided !" if opts[:rest_api_id].blank?
    catch_aws_errors do
      @table = fetch(client: :apigateway_client, operation: :get_resources, kwargs: { rest_api_id: opts[:rest_api_id] }).items.map(&:to_h)
      populate_filter_table_from_response
    end
  end
end
