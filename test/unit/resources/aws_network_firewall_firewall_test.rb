require 'helper'
require 'aws_network_firewall_firewall'
require 'aws-sdk-core'

class AWSNetworkFirewallFirewallConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSNetworkFirewallFirewall.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSNetworkFirewallFirewall.new(firewall_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSNetworkFirewallFirewall.new(unexpected: 9) }
  end
end

class AWSNetworkFirewallFirewallSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_firewall
    mock_data = {}
    mock_data[:update_token] = "test1"
    mock_data[:firewall] = {
      firewall_name: "test1",
      firewall_arn: "test1",
      firewall_policy_arn: "test1",
      vpc_id: "test1",
      subnet_mappings: [],
      delete_protection: true,
      firewall_id: "test1"
    }
    data[:data] = mock_data
    data[:client] = Aws::NetworkFirewall::Client
    @resp = AWSNetworkFirewallFirewall.new(firewall_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_configs_exists
    assert @resp.exists?
  end

  def test_update_token
    assert_equal(@resp.update_token,  'test1')
  end

  def test_firewall_name
    assert_equal(@resp.firewall.firewall_name,  'test1')
  end

  def test_firewall_arn
    assert_equal(@resp.firewall.firewall_arn,  'test1')
  end

  def test_firewall_policy_arn
    assert_equal(@resp.firewall.firewall_policy_arn,  'test1')
  end

  def test_vpc_id
    assert_equal(@resp.firewall.vpc_id,  'test1')
  end

  def test_subnet_mappings
    assert_equal(@resp.firewall.subnet_mappings,  [])
  end

  def test_delete_protection
    assert_equal(@resp.firewall.delete_protection,  true)
  end

  def test_firewall_id
    assert_equal(@resp.firewall.firewall_id,  'test1')
  end
end