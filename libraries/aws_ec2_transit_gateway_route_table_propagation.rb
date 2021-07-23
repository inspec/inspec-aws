# frozen_string_literal: true

require 'aws_backend'

class AWSEc2TransitGatewayRouteTablePropagation < AwsResourceBase
  name 'aws_ec2_transit_gateway_route_table_propagation'
  desc 'Describes information about the route table propagations for the specified transit gateway route table.'

  example "
    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'test1') do
      it { should exist }
    end
    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'test1') do
      its ('state') { should eq 'enabled }
    end
  "

  def initialize(opts = {})
    opts = { transit_gateway_route_table_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:transit_gateway_route_table_id])
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_route_table_id must be provided" unless opts[:transit_gateway_route_table_id] && !opts[:transit_gateway_route_table_id].empty?
    @display_name = opts[:transit_gateway_route_table_id]
    catch_aws_errors do
      resp = @aws.compute_client.get_transit_gateway_route_table_propagations({ transit_gateway_route_table_id: opts[:transit_gateway_route_table_id] })
      @transit_gateway_route_table_propagations = resp.transit_gateway_route_table_propagations[0].to_h
      create_resource_methods(@transit_gateway_route_table_propagations)
    end
  end

  def transit_gateway_route_table_id
    return nil unless exists?
    @transit_gateway_route_table_propagations[:transit_gateway_route_table_id]
  end

  def exists?
    !@transit_gateway_route_table_propagations.nil? && !@transit_gateway_route_table_propagations.empty?
  end

  def to_s
    "Transit Gateway Route Table ID: #{@display_name}"
  end
end