# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Deployment < AwsResourceBase
  name 'aws_api_gatewayv2_deployment'
  desc 'Gets a Deployment.'

  example "
    describe aws_api_gatewayv2_deployment(rest_api_id: 'rest_api_id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    opts = { deployment_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id deployment_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: deployment_id must be provided" unless opts[:deployment_id] && !opts[:deployment_id].empty?
    @display_name = opts[:api_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_deployment({ api_id: opts[:api_id], deployment_id: opts[:deployment_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def deployment_id
    return nil unless exists?
    @res[:deployment_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Deployment ID: #{@display_name}"
  end
end
