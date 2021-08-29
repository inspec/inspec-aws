# frozen_string_literal: true

require 'aws_backend'

class AWSEC2LocalGatewayRouteTableVPCAssociation < AwsResourceBase
  name 'aws_ec2_local_gateway_route_table_vpc_association'
  desc 'Describes the specified associations between VPCs and local gateway route tables.'

  example "
    describe aws_ec2_local_gateway_route_table_vpc_association(local_gateway_route_table_vpc_association_id: 'LocalGatewayRouteTableVpcAssociationId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { local_gateway_route_table_vpc_association_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:local_gateway_route_table_vpc_association_id])
    raise ArgumentError, "#{@__resource_name__}: local_gateway_route_table_vpc_association_id must be provided" unless opts[:local_gateway_route_table_vpc_association_id] && !opts[:local_gateway_route_table_vpc_association_id].empty?
    @display_name = opts[:local_gateway_route_table_vpc_association_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_local_gateway_route_table_vpc_associations({ local_gateway_route_table_vpc_association_ids: [opts[:local_gateway_route_table_vpc_association_id]] })
      @res = resp.local_gateway_route_table_vpc_associations[0].to_h
      create_resource_methods(@res)
    end
  end

  def local_gateway_route_table_vpc_association_id
    return nil unless exists?
    @res[:local_gateway_route_table_vpc_association_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Local Gateway Route Table VPC Association ID: #{@display_name}"
  end
end
