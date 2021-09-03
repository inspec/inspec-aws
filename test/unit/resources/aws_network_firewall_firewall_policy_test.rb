require 'helper'
require 'aws_network_firewall_firewall_policy'
require 'aws-sdk-core'

class AWSNetworkFirewallPolicyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsNetworkFirewallFirewallPolicy.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsNetworkFirewallFirewallPolicy.new(firewall_policy_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsNetworkFirewallFirewallPolicy.new(unexpected: 9) }
  end
end

class AWSNetworkFirewallPolicySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_firewall_policy
    mock_data = {}
    mock_data[:update_token] = "test1"
    mock_data[:firewall_policy_response] = {
      firewall_policy_name: 'test1',
      firewall_policy_arn: 'test1',
      firewall_policy_id: 'test1',
      description: 'test1',
      firewall_policy_status: 'test1',
      tags: []
    }
    data[:data] = mock_data
    data[:client] = Aws::NetworkFirewall::Client
    @resp = AwsNetworkFirewallFirewallPolicy.new(firewall_policy_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_configs_exists
    assert @resp.exists?
  end

  def test_update_token
    assert_equal(@resp.update_token,  'test1')
  end

  def test_firewall_policy_name
    assert_equal(@resp.firewall_policy_response.firewall_policy_name,  'test1')
  end

  def test_firewall_policy_arn
    assert_equal(@resp.firewall_policy_response.firewall_policy_arn,  'test1')
  end

  def test_firewall_policy_id
    assert_equal(@resp.firewall_policy_response.firewall_policy_id,  'test1')
  end

  def test_description
    assert_equal(@resp.firewall_policy_response.description,  'test1')
  end

  def test_firewall_policy_status
    assert_equal(@resp.firewall_policy_response.firewall_policy_status,  'test1')
  end

  def test_tags
    assert_equal(@resp.firewall_policy_response.tags,  {})
  end
end