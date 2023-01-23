require 'helper'
require 'aws_network_firewall_firewalls'
require 'aws-sdk-core'

class AWSNetworkFirewallFirewallsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSNetworkFirewallFirewalls.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSNetworkFirewallFirewalls.new('rubbish') }
  end

  def test_firewalls_non_existing_for_empty_response
    refute AWSNetworkFirewallFirewalls.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSNetworkFirewallFirewallsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_firewalls
    mock_data = {}
    mock_data[:firewall_name] = 'test1'
    mock_data[:firewall_arn] = 'test1'
    data[:data] = { :firewalls => [mock_data] }
    data[:client] = Aws::NetworkFirewall::Client
    @resp = AWSNetworkFirewallFirewalls.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_firewall_names
    assert_equal(@resp.firewall_names,  ['test1'])
  end

  def test_firewall_arns
    assert_equal(@resp.firewall_arns,  ['test1'])
  end
end