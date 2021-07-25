require 'helper'
require 'aws_ec2_vpn_connection_route'
require 'aws-sdk-core'

class AWSEc2VPNConnectionRouteConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEc2VPNConnectionRoute.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEc2VPNConnectionRoute.new(vpn_connection_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEc2VPNConnectionRoute.new(unexpected: 9) }
  end
end

class AWSEc2VPNConnectionRouteSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_vpn_connections
    mock_data = {}
    mock_data[:routes] = []
    data[:data] = { vpn_connections: [mock_data] }
    data[:client] = Aws::EC2::Client
    @vpn_connections = AWSEc2VPNConnectionRoute.new(vpn_connection_id: 'vpn-123456790123456', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpn_connection_id_exists
    assert @vpn_connections.exists
  end

  def test_routes
    assert_nil(@vpn_connections.routes, [])
  end
end