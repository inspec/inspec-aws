require 'helper'
require 'aws_network_firewall_firewall_policies'
require 'aws-sdk-core'

class AwsNetworkFirewallFirewallPoliciesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsNetworkFirewallFirewallPolicies.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsNetworkFirewallFirewallPolicies.new('rubbish') }
  end

  def test_configs_non_existing_for_empty_response
    refute AwsNetworkFirewallFirewallPolicies.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsNetworkFirewallFirewallPoliciesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_firewall_policies
    mock_data = {}
    mock_data[:name] = 'test1'
    mock_data[:arn] = 'test1'
    data[:data] = { :firewall_policies => [mock_data] }
    data[:client] = Aws::NetworkFirewall::Client
    @resp = AwsNetworkFirewallFirewallPolicies.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_names
    assert_equal(@resp.names,  ['test1'])
  end

  def test_arns
    assert_equal(@resp.arns,  ['test1'])
  end
end