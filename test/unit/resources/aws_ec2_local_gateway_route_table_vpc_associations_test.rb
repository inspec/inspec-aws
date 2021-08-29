require 'helper'
require 'aws_ec2_local_gateway_route_table_vpc_associations'
require 'aws-sdk-core'

class AWSEC2LocalGatewayRouteTableVPCAssociationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2LocalGatewayRouteTableVPCAssociations.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2LocalGatewayRouteTableVPCAssociations.new('rubbish') }
  end

  def test_local_gateway_route_table_vpc_associations_non_existing_for_empty_response
    refute AWSEC2LocalGatewayRouteTableVPCAssociations.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2LocalGatewayRouteTableVPCAssociationsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_local_gateway_route_table_vpc_associations
    mock_data = {}
    mock_data[:local_gateway_route_table_vpc_association_id] = 'test1'
    mock_data[:local_gateway_route_table_id] = 'test1'
    mock_data[:local_gateway_route_table_arn] = 'test1'
    mock_data[:local_gateway_id] = 'test1'
    mock_data[:vpc_id] = 'test1'
    mock_data[:owner_id] = 'test1'
    mock_data[:state] = 'test1'
    data[:data] = { :local_gateway_route_table_vpc_associations => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2LocalGatewayRouteTableVPCAssociations.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_local_gateway_route_table_vpc_association_ids
    assert_equal(@resp.local_gateway_route_table_vpc_association_ids, ['test1'])
  end

  def test_local_gateway_route_table_ids
    assert_equal(@resp.local_gateway_route_table_ids, ['test1'])
  end

  def test_local_gateway_route_table_arns
    assert_equal(@resp.local_gateway_route_table_arns, ['test1'])
  end

  def test_local_gateway_ids
    assert_equal(@resp.local_gateway_ids, ['test1'])
  end

  def test_vpc_ids
    assert_equal(@resp.vpc_ids, ['test1'])
  end

  def test_owner_ids
    assert_equal(@resp.owner_ids, ['test1'])
  end

  def test_states
    assert_equal(@resp.states, ['test1'])
  end
end