# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayModel < AwsResourceBase
  name 'aws_api_gateway_model'
  desc 'Retrieves API Gateway Model.'

  example "
    describe aws_api_gateway_model(api_id: 'API_ID', model_id: 'MODEL_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(api_id model_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: model_id must be provided" unless opts[:model_id] && !opts[:model_id].empty?
    @display_name = opts[:model_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_model({ api_id: opts[:api_id], model_id: opts[:model_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def model_id
    return nil unless exists?
    @res[:model_id]
  end

  def to_s
    "Model ID: #{@display_name}"
  end
end
