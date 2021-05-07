require 'helper'
require 'aws_ec2_transit_gateway_route_table_associations'
require 'aws-sdk-core'

class AwsEc2TransitGatewayRouteTableAssociationsConstructorTest < Minitest::Test

    def test_empty_params_not_ok
      assert_raises(ArgumentError) { AwsEc2TransitGatewayRouteTableAssociations.new() }
    end

    def test_valid_transit_gateway_route_table_id
      assert AwsEc2TransitGatewayRouteTableAssociations.new(transit_gateway_route_table_id: 'tgw-rtb-06ef2b1eee7ca1e19', client_args: { stub_responses: true })
    end
  
    def test_non_transit_gateway_route_table_id
      refute AwsEc2TransitGatewayRouteTableAssociations.new(transit_gateway_route_table_id: 'tgw-rtb-06ef2b1eee7ca1e19', client_args: { stub_responses: true }).exist?
    end
  
end

class AwsEc2TransitGatewayRouteTableAssociationsPathTest < Minitest::Test

    def setup
      data = {}
      data[:method] = :get_transit_gateway_route_table_associations
      mock_associations = {}
      mock_associations[:transit_gateway_attachment_id] = 'tgw-02850dffe1c3b222c'
      mock_associations[:resource_type] = 'vpc'
      mock_associations[:resource_id] = 'vpc-08b86815ee2c22d53'
      mock_associations[:state] = 'available'
      data[:data] = { :associations => [mock_associations] }
      data[:client] = Aws::EC2::Client
      @associations = AwsEc2TransitGatewayAttachments.new(
        client_args: { stub_responses: true }, stub_data: [data])
    end
  
    def test_transit_gateway_attachment_ids
      assert_equal(@associations.transit_gateway_attachment_ids, [])
    end
  
    def test_resource_types
      assert_equal(@associations.resource_types, [])
    end
  
    def test_resource_ids
      assert_equal(@associations.resource_ids, [])
    end
  
    def test_states
      assert_equal(@associations.states, [])
    end
  end
    