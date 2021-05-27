require 'helper'
require 'aws_vpn_gateway'
require 'aws-sdk-core'
require_relative 'mock/aws_vpn_gateway_mock'

class AwsVPNGatewayConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsVPNGateway.new }
  end

  def test_multiple_params_not_ok
    assert_raises(ArgumentError) { AwsVPNGateway.new(vpn_gateway_id: 'vgw-12345678', name: 'my-vgw') }
  end

  def test_invalid_id
    assert_raises(ArgumentError) { AwsVPNGateway.new(vpn_gateway_id: 'aa') }
  end

  def test_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsVPNGateway.new(random_id: 'fs-12345678') }
  end
end

class AwsVPNGatewayTest < Minitest::Test
  def setup
    @vpn_gateway = AwsVPNGatewayMock.new
    @gateway = AwsVPNGateway.new(
      vpn_gateway_id: @vpn_gateway.vpn_gateway_id,
      client_args: { stub_responses: true },
      stub_data: [@vpn_gateway.stub_data],
    )
    @gateway
  end

  def test_gateway_exists
    assert @gateway.exists?
  end

  def test_id
    assert_equal(@gateway.vpn_gateway_id, @vpn_gateway.vpn_gateway_id)
  end

  def test_vpc_id
    assert_equal(@gateway.vpc_id, @vpn_gateway.vpc_attachments.first[:vpc_id])
  end

  def test_attached
    assert @gateway.attached?
  end

  def test_detached
    refute @gateway.detached?
  end
end
