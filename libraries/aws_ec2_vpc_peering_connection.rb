# frozen_string_literal: true

require 'aws_backend'

class AWSEc2VPCPeeringConnection < AwsResourceBase
  name 'aws_ec2_vpc_peering_connection'
  desc 'Describes one or more of your VPC peering connections.'

  example "
    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'test1') do
      it { should exist }
    end
    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'test1') do
      its ('state') { should eq 'enabled }
    end
  "

  def initialize(opts = {})
    opts = { vpc_peering_connection_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:vpc_peering_connection_id])
    raise ArgumentError, "#{@__resource_name__}: vpc_peering_connection_id must be provided" unless opts[:vpc_peering_connection_id] && !opts[:vpc_peering_connection_id].empty?
    @display_name = opts[:vpc_peering_connection_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_vpc_peering_connections({ vpc_peering_connection_ids: [opts[:vpc_peering_connection_id]] })
      @vpc_peering_connections = resp.vpc_peering_connections[0].to_h
      create_resource_methods(@vpc_peering_connections)
    end
  end

  def transit_gateway_route_table_id
    return nil unless exists?
    @vpc_peering_connections[:vpc_peering_connection_id]
  end

  def exists?
    !@vpc_peering_connections.nil? && !@vpc_peering_connections.empty?
  end

  def to_s
    "VPC Peering Connection ID: #{@display_name}"
  end
end