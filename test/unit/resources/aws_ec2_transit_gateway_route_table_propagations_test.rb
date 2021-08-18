require 'helper'
require 'aws_ec2_transit_gateway_route_table_propagations'
require 'aws-sdk-core'

class AWSEc2TransitGatewayRouteTablePropagationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEc2TransitGatewayRouteTablePropagations.new(transit_gateway_route_table_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEc2TransitGatewayRouteTablePropagations.new('rubbish') }
  end

  def test_transit_gateway_route_table_propagations_non_existing_for_empty_response
    refute AWSEc2TransitGatewayRouteTablePropagations.new(transit_gateway_route_table_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSEc2TransitGatewayRouteTablePropagationsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_transit_gateway_route_table_propagations
    mock_data = {}
    mock_data[:transit_gateway_attachment_id] = 'test1'
    mock_data[:resource_id] = 'test1'
    mock_data[:resource_type] = 'test1'
    mock_data[:state] = 'test1'
    data[:data] = { :transit_gateway_route_table_propagations => [mock_data] }
    data[:client] = Aws::EC2::Client
    @transit_gateway_route_table_propagations = AWSEc2TransitGatewayRouteTablePropagations.new(transit_gateway_route_table_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_attachment_ids
    assert_equal(@transit_gateway_route_table_propagations.transit_gateway_attachment_ids, ['test1'])
  end

  def test_resource_ids
    assert_equal(@transit_gateway_route_table_propagations.resource_ids, ['test1'])
  end

  def test_resource_types
    assert_equal(@transit_gateway_route_table_propagations.resource_types, ['test1'])
  end

  def test_states
    assert_equal(@transit_gateway_route_table_propagations.states, ['test1'])
  end
end