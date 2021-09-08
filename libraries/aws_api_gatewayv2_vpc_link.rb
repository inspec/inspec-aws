# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2VPCLink < AwsResourceBase
  name 'aws_api_gatewayv2_vpc_link'
  desc 'Gets a VPC link.'

  example "
    describe get_vpc_link(vpc_link_id: 'VPCLinkID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { vpc_link_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(vpc_link_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:vpc_link_id] && !opts[:vpc_link_id].empty?
    @display_name = opts[:vpc_link_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_vpc_link({ vpc_link_id: opts[:vpc_link_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def vpc_link_id
    return nil unless exists?
    @res[:vpc_link_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "VPC Link ID: #{@display_name}"
  end
end
