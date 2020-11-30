require 'helper'
require 'aws_vpn_connections'
require 'aws-sdk-core'

class AwsVpnConnectionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsVpnConnections.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsVpnConnections.new('rubbish') }
  end

  def test_vpn_connections_non_existing_for_empty_response
    refute AwsVpnConnections.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsVpnConnectionsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_vpn_connections
    mock_vpnconnections = {}
    mock_vpnconnections[:vpn_connection_id] = "vpn-12345678"
    mock_vpnconnections[:vpn_gateway_id] = "vgw-12345678"
    mock_vpnconnections[:options] = {tunnel_options: [{outside_ip_address: "0.0.0.0", tunnel_inside_cidr: "0.0.0.0/8"}]}
    mock_vpnconnections[:type] = "type.1"
    mock_vpnconnections[:tags] = []
    mock_vpnconnections[:state] = "available"
    data[:data] = { :vpn_connections => [mock_vpnconnections] }
    data[:client] = Aws::EC2::Client
    @vpnconnections = AwsVpnConnections.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpnconnections_exists
    assert @vpnconnections.exist?
  end

  def test_vpnconnections_ids
    assert_equal(@vpnconnections.vpn_connection_ids, ['vpn-12345678'])
  end

  def test_vpnconnections_vpc_ids
    assert_equal(@vpnconnections.vpn_gateway_ids, ['vgw-12345678'])
  end

  def test_vpnconnections_outside_ip_addresses
    assert_equal(@vpnconnections.outside_ip_addresses, [["0.0.0.0"]])
  end

  def test_vpnconnections_inside_cidr_blocks
    assert_equal(@vpnconnections.tunnel_inside_cidrs, [["0.0.0.0/8"]])
  end

  def test_vpnconnections_states
    assert_equal(@vpnconnections.states, ['available'])
  end

  def test_vpnconnections_types
    assert_equal(@vpnconnections.types, ['type.1'])
  end

end
