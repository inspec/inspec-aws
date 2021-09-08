# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Model < AwsResourceBase
  name 'aws_api_gatewayv2_model'
  desc 'Gets a Model.'

  example "
    describe aws_api_gatewayv2_model(api_id: 'APIID', model_id: 'ModelID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    opts = { model_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id model_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: model_id must be provided" unless opts[:model_id] && !opts[:model_id].empty?
    @display_name = opts[:model_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_model({ api_id: opts[:api_id], model_id: opts[:model_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def model_id
    return nil unless exists?
    @res[:model_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Model ID: #{@display_name}"
  end
end
