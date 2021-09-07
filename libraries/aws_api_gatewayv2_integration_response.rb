# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayRestApi < AwsResourceBase
  name 'aws_api_gatewayv2_integration_response'
  desc 'Lists'

  example "
    describe aws_api_gatewayv2_integration_response(rest_api_id: 'rest_api_id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    opts = { integration_id: opts } if opts.is_a?(String)
    opts = { integration_response_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id integration_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: integration_id must be provided" unless opts[:integration_id] && !opts[:integration_id].empty?
    raise ArgumentError, "#{@__resource_name__}: integration_response_id must be provided" unless opts[:integration_response_id] && !opts[:integration_response_id].empty?
    @display_name = opts[:integration_response_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_integration_response({ api_id: opts[:api_id], integration_id: opts[:integration_id], integration_response_id: opts[:integration_response_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def integration_response_id
    return nil unless exists?
    @res[:integration_response_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Integration Response ID: #{@display_name}"
  end
end
