require 'helper'
require 'aws_network_firewall_rule_groups'
require 'aws-sdk-core'

class AWSNetworkFirewallRuleGroupsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSNetworkFirewallRuleGroups.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSNetworkFirewallRuleGroups.new('rubbish') }
  end

  def test_rule_groups_non_existing_for_empty_response
    refute AWSNetworkFirewallRuleGroups.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSNetworkFirewallRuleGroupsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_rule_groups
    mock_data = {}
    mock_data[:name] = 'test1'
    mock_data[:arn] = 'test1'
    data[:data] = { :rule_groups => [mock_data] }
    data[:client] = Aws::NetworkFirewall::Client
    @resp = AWSNetworkFirewallRuleGroups.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_names
    assert_equal(@resp.names,  ['test1'])
  end

  def test_arns
    assert_equal(@resp.arns,  ['test1'])
  end
end