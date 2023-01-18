require 'helper'
require 'aws_ec2_transit_gateway_route_table_associations'
require 'aws-sdk-core'

class AwsEc2TransitGatewayRouteTableAssociationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsEc2TransitGatewayRouteTableAssociations.new(transit_gateway_route_table_id: "test", client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsEc2TransitGatewayRouteTableAssociations.new('rubbish') }
  end

  def test_transit_gateway_route_table_associations_non_existing_for_empty_response
    refute AwsEc2TransitGatewayRouteTableAssociations.new(transit_gateway_route_table_id: "test", client_args: { stub_responses: true }).exist?
  end
end

class AwsEc2TransitGatewayRouteTableAssociationsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_transit_gateway_route_table_associations
    mock_data = {}
    mock_data[:transit_gateway_attachment_id] = 'test'
    mock_data[:resource_id] = 'test'
    mock_data[:resource_type] = 'test'
    mock_data[:state] = 'test'
    data[:data] = { :associations => [mock_data] }
    data[:client] = Aws::EC2::Client
    @associations = AwsEc2TransitGatewayRouteTableAssociations.new(transit_gateway_route_table_id: "test", client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_associations_exists
    assert @associations.exist?
  end

  def test_transit_gateway_attachment_ids
    assert_equal(@associations.transit_gateway_attachment_ids, ['test'])
  end

  def test_resource_ids
    assert_equal(@associations.resource_ids, ['test'])
  end

  def test_resource_types
    assert_equal(@associations.resource_types, ['test'])
  end

  def test_states
    assert_equal(@associations.states, ['test'])
  end
end