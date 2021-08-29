require 'helper'
require 'aws_ec2_local_gateway_route'
require 'aws-sdk-core'

class AWSEC2LocalGatewayRouteConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2LocalGatewayRoute.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2LocalGatewayRoute.new(local_gateway_route_table_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2LocalGatewayRoute.new(unexpected: 9) }
  end
end

class AWSEC2LocalGatewayRouteSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :search_local_gateway_routes
    mock_data = {}
    mock_data[:destination_cidr_block] = 'test1'
    mock_data[:local_gateway_virtual_interface_group_id] = 'test1'
    mock_data[:state] = 'test1'
    mock_data[:local_gateway_route_table_id] = 'test1'
    mock_data[:local_gateway_route_table_arn] = 'test1'
    mock_data[:owner_id] = 'test1'
    data[:data] = { routes: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2LocalGatewayRoute.new(local_gateway_route_table_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_routes_exists
    assert @resp.exists?
  end

  def test_destination_cidr_block
    assert_equal(@resp.destination_cidr_block, 'test1')
  end

  def test_local_gateway_virtual_interface_group_id
    assert_equal(@resp.local_gateway_virtual_interface_group_id, 'test1')
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end

  def test_local_gateway_route_table_id
    assert_equal(@resp.local_gateway_route_table_id, 'test1')
  end

  def test_local_gateway_route_table_arn
    assert_equal(@resp.local_gateway_route_table_arn, 'test1')
  end

  def test_owner_id
    assert_equal(@resp.owner_id, 'test1')
  end
end