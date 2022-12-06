require 'aws_backend'

class AWSApiGatewayRequestValidators < AwsCollectionResourceBase
  name 'aws_api_gateway_request_validators'
  desc 'Gets the RequestValidators collection of a given RestApi.'

  example "
    describe aws_api_gateway_request_validators(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" if opts[:rest_api_id].blank?
    @table = fetch(client: :apigateway_client, operation: :get_request_validators, kwargs: { rest_api_id: opts[:rest_api_id] }).items.map(&:to_h)
    populate_filter_table_from_response
  end
end
