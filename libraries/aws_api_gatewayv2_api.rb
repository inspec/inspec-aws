# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2API < AwsResourceBase
  name 'aws_api_gatewayv2_api'
  desc 'Gets an Api resource.'

  example "
    describe aws_api_gatewayv2_api(api_id: 'api_id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
    @display_name = opts[:api_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_api({ api_id: opts[:api_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def api_id
    return nil unless exists?
    @res[:api_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Rest API ID: #{@display_name}"
  end
end
