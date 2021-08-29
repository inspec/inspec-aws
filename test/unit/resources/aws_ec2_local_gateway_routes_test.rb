require 'helper'
require 'aws_ec2_local_gateway_routes'
require 'aws-sdk-core'

class AWSEC2LocalGatewayRoutesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2LocalGatewayRoute.new(local_gateway_route_table_id: 'test1', client_args: { stub_responses: true })
  end
end

class AWSEC2LocalGatewayRoutesHappyPathTest < Minitest::Test

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
    data[:data] = { :routes => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2LocalGatewayRoutes.new(local_gateway_route_table_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_routes_exists
    assert @resp.exists?
  end

  def test_destination_cidr_blocks
    assert_equal(@resp.destination_cidr_blocks, ['test1'])
  end

  def test_local_gateway_virtual_interface_group_ids
    assert_equal(@resp.local_gateway_virtual_interface_group_ids, ['test1'])
  end

  def test_states
    assert_equal(@resp.states, ['test1'])
  end

  def test_local_gateway_route_table_ids
    assert_equal(@resp.local_gateway_route_table_ids, ['test1'])
  end

  def test_local_gateway_route_table_arns
    assert_equal(@resp.local_gateway_route_table_arns, ['test1'])
  end

  def test_owner_ids
    assert_equal(@resp.owner_ids, ['test1'])
  end
end