require 'helper'
require 'aws_transit_gateway'
require 'aws-sdk-core'

class AwsTransitGatewayConstructorTest < Minitest::Test

begin
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsTransitGateway.new }
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsTransitGateway.new(rubbish:'rubbish') }
  end
end
end

class AwsTransitGatewayHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_transit_gateways
    mock_transit_gateway = {}
    mock_transit_gateway[:transit_gateway_id] = 'tgw-12345678'
    mock_transit_gateway[:transit_gateway_arn] = 'arn:aws:ec2:eu-west-1:123456789101112:transit-gateway/tgw-12345678'
    mock_transit_gateway[:owner_id] = '123456789101112'
    mock_transit_gateway[:options] = {
         :dns_support=> 'enable',
         :association_default_route_table_id=> 'tgw-rtb-05c92dad2f6a6c2a6',
         :propagation_default_route_table_id=> 'tgw-rtb-05c92dad2f6a6c2a6',
         :vpn_ecmp_support=> 'enable'
    }
    data[:data] = { :transit_gateways => [mock_transit_gateway] }
    data[:client] = Aws::EC2::Client
    @transit_gateway = AwsTransitGateway.new(transit_gateway_id: 'tgw-12345678', client_args: { stub_responses: true }, stub_data: [data])
  end


  def test_transit_gateway_exists
    assert @transit_gateway.exists?
  end

  def test_transit_gateway_id
    assert_equal(@transit_gateway.transit_gateway_id, 'tgw-12345678')
  end

  def test_transit_gateway_arn
    assert_equal(@transit_gateway.transit_gateway_arn, 'arn:aws:ec2:eu-west-1:123456789101112:transit-gateway/tgw-12345678')  
  end

  def test_transit_gateway_owner_id
    assert_equal(@transit_gateway.transit_gateway_owner_id, '123456789101112')  
  end

  def test_dns_support
    assert_equal(@transit_gateway.dns_support, 'enable')  
  end

  def test_default_route_table_id
    assert_equal(@transit_gateway.default_route_table_id, 'tgw-rtb-05c92dad2f6a6c2a6')  
  end

  def test_propagation_default_route_table_id
    assert_equal(@transit_gateway.propagation_default_route_table_id, 'tgw-rtb-05c92dad2f6a6c2a6')  
  end

  def test_vpn_ecmp_support
    assert_equal(@transit_gateway.vpn_ecmp_support, 'enable')  
  end
end
