# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2RouteResponse < AwsResourceBase
  name 'aws_api_gatewayv2_route_response'
  desc 'Gets a Route Response.'

  example "
    describe aws_api_gatewayv2_route_response(api_id: 'APIID', route_id: 'RouteID', route_response_id: 'RouteResponseID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    opts = { route_id: opts } if opts.is_a?(String)
    opts = { rest_api_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id route_id route_response_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: route_id must be provided" unless opts[:route_id] && !opts[:route_id].empty?
    raise ArgumentError, "#{@__resource_name__}: route_response_id must be provided" unless opts[:route_response_id] && !opts[:route_response_id].empty?
    @display_name = opts[:route_response_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_route_response({ api_id: opts[:api_id], route_id: opts[:route_id], route_response_id: opts[:route_response_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def route_response_id
    return nil unless exists?
    @res[:route_response_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Route Response ID: #{@display_name}"
  end
end
