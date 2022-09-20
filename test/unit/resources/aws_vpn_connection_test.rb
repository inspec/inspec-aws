require 'helper'
require 'aws_vpn_connection'
require 'aws-sdk-core'
require_relative 'mock/aws_vpn_connection_mock'

class AwsVPNConnectionConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsVPNConnection.new }
  end

  def test_multiple_params_not_ok
    assert_raises(ArgumentError) { AwsVPNConnection.new(vpn_connection_id: 'vpn-12345678', name: 'my-vgw') }
  end

  def test_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsVPNConnection.new(random_id: 'fs-12345678') }
  end
end

class AwsVPNConnectionTest < Minitest::Test
  
  def setup
    @vpn_connection = AwsVPNConnectionMock.new
    @connection = AwsVPNConnection.new(
      vpn_connection_id: @vpn_connection.vpn_connection_id,
      client_args: { stub_responses: true },
      stub_data: [@vpn_connection.stub_data],
    )
    @connection
  end

  def test_vpn_connection_exists
    assert @connection.exists?
  end

  def test_resource_id
    refute_nil(@connection.resource_id)
    assert_equal(@connection.resource_id, @vpn_connection.vpn_connection_id)
  end

  def test_customer_gateway_configuration
    assert_equal(@connection.customer_gateway_configuration, @vpn_connection.customer_gateway_configuration)
  end

  def test_customer_gateway_id
    assert_equal(@connection.customer_gateway_id, @vpn_connection.customer_gateway_id)
  end

  def test_category
    assert_equal(@connection.category, @vpn_connection.category)
  end

  def test_state
    assert_equal(@connection.state, @vpn_connection.state)
  end

  def test_type
    assert_equal(@connection.type, @vpn_connection.type)
  end

  def test_vpn_connection_id
    assert_equal(@connection.vpn_connection_id, @vpn_connection.vpn_connection_id)
  end

  def test_vpn_gateway_id
    assert_equal(@connection.vpn_gateway_id, @vpn_connection.vpn_gateway_id)
  end

  def test_transit_gateway_id
    assert_equal(@connection.transit_gateway_id, @vpn_connection.transit_gateway_id)
  end

  def test_core_network_arn
    assert_equal(@connection.core_network_arn, @vpn_connection.core_network_arn)
  end

  def test_core_network_attachment_arn
    assert_equal(@connection.core_network_attachment_arn, @vpn_connection.core_network_attachment_arn)
  end

  def test_gateway_association_state
    assert_equal(@connection.gateway_association_state, @vpn_connection.gateway_association_state)
  end
end
