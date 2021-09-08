# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Integration < AwsResourceBase
  name 'aws_api_gatewayv2_integration'
  desc 'Gets an Integration.'

  example "
    describe aws_api_gatewayv2_integration(api_id: 'api_id', integration_id: 'integration_id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    opts = { integration_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id integration_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: integration_id must be provided" unless opts[:integration_id] && !opts[:integration_id].empty?
    @display_name = opts[:integration_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_integration({ api_id: opts[:api_id], integration_id: opts[:integration_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def integration_id
    return nil unless exists?
    @res[:integration_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Integration ID: #{@display_name}"
  end
end
