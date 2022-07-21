require 'helper'
require 'aws_vpn_connection'
require 'aws-sdk-core'
require_relative 'mock/aws_vpn_connection_mock'

class AwsVPNConnectionConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsVPNConnection.new }
  end

  def test_multiple_params_not_ok
    assert_raises(ArgumentError) { AwsVPNConnection.new(vpn_connection_id: 'vgw-12345678', name: 'my-vgw') }
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

  def test_connection_exists
    assert @connection.exists?
  end

  def test_id
    assert_equal(@connection.vpn_connection_id, @vpn_connection.vpn_connection_id)
  end

  def test_resource_id
    refute_nil(@connection.resource_id)
    assert_equal(@connection.resource_id, @vpn_connection.vpn_connection_id)
  end
end