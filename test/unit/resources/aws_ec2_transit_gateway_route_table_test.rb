require 'helper'
require 'aws_ec2_transit_gateway_route_table'
require 'aws-sdk-core'

class AwsEc2TransitGatewayRouteTableConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEc2TransitGatewayRouteTable.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_transit_gateway_route_table_id_as_hash_eight_sign
    AwsEc2TransitGatewayRouteTable.new(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f', client_args: { stub_responses: true })
  end

  def test_accepts_transit_gateway_route_table_id_as_hash
    AwsEc2TransitGatewayRouteTable.new(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsEc2TransitGatewayRouteTable.new(rubbish: 9) }
  end
end

class AwsEc2TransitGatewayRouteTablePathTest < Minitest::Test

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
    @resp = AwsEc2TransitGatewayRouteTable.new(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f',client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_route_table_id_exists
    assert @resp.exists?
  end

  def test_transit_gateway_route_table_id_available
    assert @resp.available?
  end

  def test_transit_gateway_route_table_id
    assert_equal(@resp.transit_gateway_route_table_id, 'tgw-rtb-052d947d91b6bb69f')
  end

  def test_transit_gateway_id
    assert_equal(@resp.transit_gateway_id, 'tgw-06479f73c993542ec')
  end

  def test_state
    assert_equal(@resp.state, 'available')
  end

  def test_default_association_route_table
    assert_equal(@resp.default_association_route_table, true)
  end

  def test_default_propagation_route_table
    assert_equal(@resp.default_propagation_route_table, true)
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, @resp.transit_gateway_route_table_id)
  end
end
