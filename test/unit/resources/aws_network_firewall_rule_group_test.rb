require 'helper'
require 'aws_network_firewall_rule_group'
require 'aws-sdk-core'

class AWSNetworkFirewallRuleGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSNetworkFirewallRuleGroup.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSNetworkFirewallRuleGroup.new(rule_group_arn: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSNetworkFirewallRuleGroup.new(unexpected: 9) }
  end
end

class AWSNetworkFirewallRuleGroupSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_rule_group
    mock_data = {}
    mock_data[:update_token] = "test1"
    mock_data[:rule_group_response] = {
      rule_group_arn: "test1",
      rule_group_name: "test1",
      rule_group_id: "test1",
    }
    data[:data] = mock_data
    data[:client] = Aws::NetworkFirewall::Client
    @resp = AWSNetworkFirewallRuleGroup.new(rule_group_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_configs_exists
    assert @resp.exists?
  end

  def test_update_token
    assert_equal(@resp.update_token,  'test1')
  end

  def test_rule_group_arn
    assert_equal(@resp.rule_group_response.rule_group_arn,  'test1')
  end

  def test_rule_group_name
    assert_equal(@resp.rule_group_response.rule_group_name,  'test1')
  end

  def test_rule_group_id
    assert_equal(@resp.rule_group_response.rule_group_id,  'test1')
  end
end