require 'helper'
require 'aws_vpn_gateways'
require 'aws-sdk-core'
require_relative 'mock/aws_vpn_gateway_mock'

class AwsVPNGatewaysConstructorTest < Minitest::Test
  def test_empty_params_ok
    assert AwsVPNGateways.new(client_args: { stub_responses: true })
  end

  def test_params_not_ok
    assert_raises(ArgumentError) { AwsVPNGateways.new(id: 'vgw-12345678') }
  end

  def test_non_existing_vgws
    refute AwsVPNGateways.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsVPNGatewaysTest < Minitest::Test
  def setup
    @mock_gateway = AwsVPNGatewayMock.new
    # Create stub gateways with mock data.
    @gateways = AwsVPNGateways.new(
      client_args: { stub_responses: true },
      stub_data: [@mock_gateway.multiple_stub_data],
    )
  end

  def test_gateways_exists
    assert @gateways.exist?
  end

  def test_vpn_gateway_ids
    assert_includes(@gateways.vpn_gateway_ids, @mock_gateway.vpn_gateway_id)
  end

  def test_attached
    assert_includes(@gateways.vpc_attachments, @mock_gateway.vpc_attachments.first)
  end

  def test_amazon_side_asns
    assert_includes(@gateways.amazon_side_asns, @mock_gateway.amazon_side_asn)
  end
end
