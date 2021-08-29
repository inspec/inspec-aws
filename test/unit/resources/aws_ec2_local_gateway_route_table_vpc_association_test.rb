require 'helper'
require 'aws_ec2_local_gateway_route_table_vpc_association'
require 'aws-sdk-core'

class AWSEC2LocalGatewayRouteTableVPCAssociationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2LocalGatewayRouteTableVPCAssociation.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2LocalGatewayRouteTableVPCAssociation.new(local_gateway_route_table_vpc_association_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2LocalGatewayRouteTableVPCAssociation.new(unexpected: 9) }
  end
end

class AWSEC2LocalGatewayRouteTableVPCAssociationSuccessPathTest < Minitest::Test

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
    data[:data] = { local_gateway_route_table_vpc_associations: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2LocalGatewayRouteTableVPCAssociation.new(local_gateway_route_table_vpc_association_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_local_gateway_route_table_vpc_associations_exists
    assert @resp.exists?
  end

  def test_local_gateway_route_table_vpc_association_id
    assert_equal(@resp.local_gateway_route_table_vpc_association_id, 'test1')
  end

  def test_local_gateway_route_table_id
    assert_equal(@resp.local_gateway_route_table_id, 'test1')
  end

  def test_local_gateway_route_table_arn
    assert_equal(@resp.local_gateway_route_table_arn, 'test1')
  end

  def test_local_gateway_id
    assert_equal(@resp.local_gateway_id, 'test1')
  end

  def test_vpc_id
    assert_equal(@resp.vpc_id, 'test1')
  end

  def test_owner_id
    assert_equal(@resp.owner_id, 'test1')
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end
end