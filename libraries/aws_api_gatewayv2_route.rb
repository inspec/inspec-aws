# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Route < AwsResourceBase
  name 'aws_api_gatewayv2_route'
  desc 'Gets a Route.'

  example "
    describe aws_api_gatewayv2_route(api_id: 'APIID', route_id: 'RouteID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    opts = { route_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id route_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: route_id must be provided" unless opts[:route_id] && !opts[:route_id].empty?
    @display_name = opts[:route_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_route({ api_id: opts[:api_id], route_id: opts[:route_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def route_id
    return nil unless exists?
    @res[:route_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Route ID: #{@display_name}"
  end
end
