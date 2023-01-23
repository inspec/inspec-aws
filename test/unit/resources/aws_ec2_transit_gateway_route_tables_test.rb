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

  def test_transit_gateway_route_tables_non_existing_for_empty_response
    refute AwsEc2TransitGatewayRouteTables.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEc2TransitGatewayRouteTablesPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_transit_gateway_route_tables
    mock_transit_gateway_route_tables = {}
    mock_transit_gateway_route_tables[:transit_gateway_route_table_id] = 'tgw-rtb-052d947d91b6bb69f'
    mock_transit_gateway_route_tables[:transit_gateway_id] = 'tgw-06479f73c993542ec'
    mock_transit_gateway_route_tables[:state] = 'available'
    mock_transit_gateway_route_tables[:default_association_route_table] = true
    mock_transit_gateway_route_tables[:default_propagation_route_table] = true
    data[:data] = { :transit_gateway_route_tables => [mock_transit_gateway_route_tables] }
    data[:client] = Aws::EC2::Client
    @transit_gateway_route_tables = AwsEc2TransitGatewayRouteTables.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_route_table_id_exists
    assert @transit_gateway_route_tables.exist?
  end

  def test_transit_gateway_route_table_ids
    assert_equal(@transit_gateway_route_tables.transit_gateway_route_table_ids, ['tgw-rtb-052d947d91b6bb69f'])
  end

  def test_transit_gateway_ids
    assert_equal(@transit_gateway_route_tables.transit_gateway_ids, ['tgw-06479f73c993542ec'])
  end

  def test_states
    assert_equal(@transit_gateway_route_tables.states, ['available'])
  end

  def test_default_association_route_tables
    assert_equal(@transit_gateway_route_tables.default_association_route_tables, [true])
  end

  def test_default_propagation_route_tables
    assert_equal(@transit_gateway_route_tables.default_propagation_route_tables, [true])
  end
end