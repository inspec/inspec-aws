# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayRestApi < AwsResourceBase
  name 'aws_api_gateway_restapi'
  desc 'Lists the RestApi resource in the collection.'

  example "
    describe aws_api_gateway_restapi(rest_api_id: 'rest_api_id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { rest_api_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(rest_api_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    @display_name = opts[:rest_api_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_rest_api({ rest_api_id: opts[:rest_api_id] })
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
