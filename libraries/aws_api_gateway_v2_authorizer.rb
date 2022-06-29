# frozen_string_literal: true

require 'aws_backend'

class AwsApiGatewayV2Authorizer < AwsResourceBase
  name 'aws_api_gateway_v2_authorizer'
  desc 'Gets an Authorizer.'
  example <<-EXAMPLE
    describe aws_api_gateway_v2_authorizer(api_id: 'API_ID', authorizer_id: 'AUTHORIZER_ID') do
      it { should exist }
      its('id') { should eq 'AUTHORIZER_ID' }
      its('name') { should eq 'AUTHORIZER_NAME' }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts, authorizer_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id authorizer_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    raise ArgumentError, "#{@__resource_name__}: authorizer_id must be provided!" if opts[:authorizer_id].blank?
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
    !@res.blank?
  end

  def resource_id
    @res? @res[:authorizer_id] : @display_name
  end

  def to_s
    "Authorizer ID: #{@display_name}"
  end
end
