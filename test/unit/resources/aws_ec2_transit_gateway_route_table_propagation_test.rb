require 'helper'
require 'aws_ec2_transit_gateway_route_table_propagation'
require 'aws-sdk-core'

class AWSEc2TransitGatewayRouteTablePropagationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEc2TransitGatewayRouteTablePropagation.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEc2TransitGatewayRouteTablePropagation.new(transit_gateway_route_table_id: '', transit_gateway_attachment_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEc2TransitGatewayRouteTablePropagation.new(unexpected: 9) }
  end
end

class AWSEc2TransitGatewayRouteTablePropagationSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_transit_gateway_route_table_propagations
    mock_data = {}
    mock_data[:transit_gateway_attachment_id] = 'test1'
    mock_data[:resource_id] = 'test1'
    mock_data[:resource_type] = 'test1'
    mock_data[:state] = 'test1'
    data[:data] = { transit_gateway_route_table_propagations: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEc2TransitGatewayRouteTablePropagation.new(transit_gateway_route_table_id: 'test1', transit_gateway_attachment_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_route_table_propagations_exists
    assert @resp.exists?
  end

  def test_transit_gateway_attachment_id
    assert_equal(@resp.transit_gateway_attachment_id, 'test1')
  end

  def test_resource_id
    assert_equal(@resp.resource_id, 'test1')
  end

  def test_resource_type
    assert_equal(@resp.resource_type, 'test1')
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end
end
