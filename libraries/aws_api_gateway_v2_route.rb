require "aws_backend"

class AwsApiGatewayV2Route < AwsResourceBase
  name "aws_api_gateway_v2_route"
  desc "Gets a Route."
  example <<-EXAMPLE
    describe aws_api_gateway_v2_route(api_id: 'APP_ID', route_id: 'ROUTE_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts, route_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id route_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    raise ArgumentError, "#{@__resource_name__}: route_id must be provided!" if opts[:route_id].blank?
    @display_name = opts[:route_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_route({ api_id: opts[:api_id], route_id: opts[:route_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def route_id
    return unless exists?
    @res[:route_id]
  end

  def exists?
    !@res.blank?
  end

  def resource_id
    @res? @res[:route_id]: @display_name
  end

  def to_s
    "Route ID: #{@display_name}"
  end
end
