# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayRequestValidator < AwsResourceBase
  name 'aws_api_gateway_request_validator'
  desc 'Gets a RequestValidator of a given RestApi.'

  example "
    describe aws_api_gateway_request_validator(rest_api_id: 'REST_API_ID', request_validator_id: 'REQUEST_VALIDATOR_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id request_validator_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: request_validator_id must be provided" unless opts[:request_validator_id] && !opts[:request_validator_id].empty?
    @display_name = opts[:request_validator_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_request_validator({ rest_api_id: opts[:rest_api_id], request_validator_id: opts[:request_validator_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def request_validator_id
    return nil unless exists?
    @res[:request_validator_id]
  end

  def to_s
    "Request Validator ID: #{@display_name}"
  end
end
