# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Authorizer < AwsResourceBase
  name 'aws_api_gatewayv2_authorizer'
  desc 'Gets an Authorizer.'

  example "
    describe aws_api_gatewayv2_authorizer(api_id: 'APIID', authorizer_id: 'AuthorizerID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { api_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id authorizer_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: authorizer_id must be provided" unless opts[:authorizer_id] && !opts[:authorizer_id].empty?
    @display_name = opts[:authorizer_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_authorizer({ api_id: opts[:api_id], authorizer_id: opts[:authorizer_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def authorizer_id
    return nil unless exists?
    @res[:authorizer_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Authorizer ID: #{@display_name}"
  end
end
