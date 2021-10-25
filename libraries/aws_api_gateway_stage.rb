# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayStage < AwsResourceBase
  name 'aws_api_gateway_stage'
  desc 'Gets information about a Stage resource.'

  example "
    describe aws_api_gateway_stage(rest_api_id: 'rest_api_id', stage_name: 'stage_name') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id stage_name))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: stage_name must be provided" unless opts[:stage_name] && !opts[:stage_name].empty?
    @display_name = opts[:rest_api_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_stage({ rest_api_id: opts[:rest_api_id], stage_name: opts[:stage_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def rest_api_id
    return nil unless exists?
    @res[:rest_api_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "rest_api_id: #{@display_name}"
  end
end
