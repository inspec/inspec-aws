require 'helper'
require 'aws_ec2_transit_gateway_route_table_association'
require 'aws-sdk-core'

class AwsEc2TransitGatewayRouteTableAssociationConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEc2TransitGatewayRouteTableAssociation.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_transit_gateway_route_table_id_as_hash_eight_sign
    AwsEc2TransitGatewayRouteTableAssociation.new(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f', client_args: { stub_responses: true })
  end

  def test_accepts_transit_gateway_route_table_id_as_hash
    AwsEc2TransitGatewayRouteTableAssociation.new(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsEc2TransitGatewayRouteTableAssociation.new(rubbish: 9) }
  end
end

class AwsEc2TransitGatewayRouteTableAssociationPathTest < Minitest::Test

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
        @associations = AwsEc2TransitGatewayRouteTableAssociation.new(
            transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f', client_args: { stub_responses: true }, stub_data: [data])
    end

    def test_transit_gateway_route_table_id_exists
        assert @associations.exists?
    end
  
    def test_transit_gateway_route_table_id_available
        assert @associations.available?
    end

    def test_transit_gateway_attachment_id
        assert_equal(@associations.transit_gateway_attachment_id, 'tgw-02850dffe1c3b222c')
    end

    def test_resource_type
        assert_equal(@associations.resource_type, 'vpc')
    end

    def test_resource_id
        assert_equal(@associations.resource_id, 'vpc-08b86815ee2c22d53')
    end

    def test_state
        assert_equal(@associations.state, 'available')
    end
end