require 'helper'
require 'aws_ec2_transit_gateway_route_tables'
require 'aws-sdk-core'

class AwsEc2TransitGatewayRouteTablesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsEc2TransitGatewayRouteTables.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsEc2TransitGatewayRouteTables.new('rubbish') }
  end

  def test_Ec2TransitGatewayRouteTables_non_existing_for_empty_response
    refute AwsEc2TransitGatewayRouteTables.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEc2TransitGatewayRouteTablesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_transit_gateway_route_tables
    mock_transit_gateway_route_table = {}
    mock_transit_gateway_route_table[:transit_gateway_route_table_id] = 'tgw-rtb-052d947d91b6bb69f'
    mock_transit_gateway_route_table[:transit_gateway_id] = 'tgw-06479f73c993542ec'
    mock_transit_gateway_route_table[:state] = 'available'
    mock_transit_gateway_route_table[:default_association_route_table] = true
    mock_transit_gateway_route_table[:default_propagation_route_table] = true
    mock_transit_gateway_route_table[:tags] = 'default'
    data[:data] = { :Ec2TransitGatewayRouteTables => [mock_transit_gateway_route_table] }
    data[:client] = Aws::EC2::Client
    @Ec2TransitGatewayRouteTables = AwsEc2TransitGatewayRouteTables.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_Ec2TransitGatewayRouteTables_exists
    assert @Ec2TransitGatewayRouteTables.exist?
  end

  def test_Ec2TransitGatewayRouteTables_ids
    assert_equal(@Ec2TransitGatewayRouteTables.transit_gateway_route_table_ids, ['tgw-rtb-052d947d91b6bb69f'])
  end

  def test_Ec2TransitGatewayRouteTables_cidr_blocks
    assert_equal(@Ec2TransitGatewayRouteTables.transit_gateway_ids, ['tgw-06479f73c993542ec'])
  end

  def test_Ec2TransitGatewayRouteTables_states
    assert_equal(@Ec2TransitGatewayRouteTables.states, ['available'])
  end

  def test_Ec2TransitGatewayRouteTables_instance_tenancys
    assert_equal(@Ec2TransitGatewayRouteTables.default_association_route_tables, [true])
  end

  def test_Ec2TransitGatewayRouteTables_dhcp_options_ids
    assert_equal(@Ec2TransitGatewayRouteTables.default_propagation_route_tables, [true])
  end

  def test_Ec2TransitGatewayRouteTables_creation_times
    assert_equal(@Ec2TransitGatewayRouteTables.is_defaults, ['default'])
  end

  def test_Ec2TransitGatewayRouteTables_tags
    assert_equal(@Ec2TransitGatewayRouteTables.is_defaults, ['default'])
  end
end