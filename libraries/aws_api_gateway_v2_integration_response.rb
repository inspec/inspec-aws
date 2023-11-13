require "aws_backend"

class AwsApiGatewayV2IntegrationResponse < AwsResourceBase
  name "aws_api_gateway_v2_integration_response"
  desc "Gets an IntegrationResponse for an Integration."
  example <<-EXAMPLE
    describe aws_api_gateway_v2_integration_response(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID', integration_response_id: 'INTEGRATION_RESPONSE_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts, integration_id: opts, integration_response_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id integration_id integration_response_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    raise ArgumentError, "#{@__resource_name__}: integration_id must be provided!" if opts[:integration_id].blank?
    raise ArgumentError, "#{@__resource_name__}: integration_response_id must be provided!" if opts[:integration_response_id].blank?
    @display_name = opts[:integration_response_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_integration_response({ api_id: opts[:api_id], integration_id: opts[:integration_id], integration_response_id: opts[:integration_response_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def integration_response_id
    return unless exists?
    @res[:integration_response_id]
  end

  def exists?
    !@res.blank?
  end

  def resource_id
    @res? @res[:integration_response_id]: @display_name
  end

  def to_s
    "Integration Response ID: #{@display_name}"
  end
end
