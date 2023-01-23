require 'helper'
require 'aws_ec2_transit_gateway_route_table_association'
require 'aws-sdk-core'

class AwsEc2TransitGatewayRouteTableAssociationConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEc2TransitGatewayRouteTableAssociation.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_transit_gateway_route_table_id_as_hash_eight_sign
    AwsEc2TransitGatewayRouteTableAssociation.new(transit_gateway_route_table_id: 'test', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsEc2TransitGatewayRouteTableAssociation.new(rubbish: 9) }
  end
end

class AwsEc2TransitGatewayRouteTableAssociationPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_transit_gateway_route_table_associations
    mock_data = {}
    mock_data[:transit_gateway_attachment_id] = 'test'
    mock_data[:resource_id] = 'test'
    mock_data[:state] = 'test'
    data[:data] = { :associations => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AwsEc2TransitGatewayRouteTableAssociation.new(transit_gateway_route_table_id: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_route_table_id_exists
    assert @resp.exists?
  end

  def test_transit_gateway_route_table_id_available
    assert @resp.available?
  end

  def test_transit_gateway_attachment_id
    assert_equal(@resp.transit_gateway_attachment_id, 'test')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test')
  end

  def test_state
    assert_equal(@resp.state, 'test')
  end
end
