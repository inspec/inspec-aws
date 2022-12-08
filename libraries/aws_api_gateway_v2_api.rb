require "aws_backend"

class AwsApiGatewayV2Api < AwsResourceBase
  name "aws_api_gateway_v2_api"
  desc "Gets information about the current ApiKey resource."
  example <<-EXAMPLE
    describe aws_api_gateway_v2_api(api_id: 'REST_API_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    @display_name = opts[:api_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_api({ api_id: opts[:api_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def api_id
    return nil unless exists?
    @res[:api_id]
  end

  def exists?
    !@res.blank?
  end

  def resource_id
    @res? @res[:api_endpoint] : @display_name
  end

  def to_s
    "API Key: #{@display_name}"
  end
end
