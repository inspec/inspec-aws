# frozen_string_literal: true

require 'aws_backend'

class AWSEC2LocalGatewayRouteTableVPCAssociation < AwsResourceBase
  name 'aws_ec2_local_gateway_route_table_vpc_association'
  desc 'Returns'

  example "
    describe aws_ec2_local_gateway_route_table_vpc_association(function_name: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { function_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:function_name])
    raise ArgumentError, "#{@__resource_name__}: function_name must be provided" unless opts[:function_name] && !opts[:function_name].empty?
    @display_name = opts[:instance_profile_name]
    catch_aws_errors do
      resp = @aws.compute_client.describe_local_gateway_route_table_vpc_associations({ function_name: opts[:function_name] })
      @res = resp.local_gateway_route_table_vpc_associations.to_h
      create_resource_methods(@res)
    end
  end

  def function_name
    return nil unless exists?
    @res[:function_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Function Name: #{@display_name}"
  end
end
