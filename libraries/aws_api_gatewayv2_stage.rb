# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Stage < AwsResourceBase
  name 'aws_api_gatewayv2_stage'
  desc 'Gets a Stage.'

  example "
    describe aws_api_gatewayv2_stage(api_id: 'APIID', stage_name: 'StageName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    opts = { stage_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id stage_name))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: stage_name must be provided" unless opts[:stage_name] && !opts[:stage_name].empty?
    @display_name = opts[:stage_name]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_stage({ api_id: opts[:api_id], stage_name: opts[:stage_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def stage_name
    return nil unless exists?
    @res[:stage_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Stage Name: #{@display_name}"
  end
end
