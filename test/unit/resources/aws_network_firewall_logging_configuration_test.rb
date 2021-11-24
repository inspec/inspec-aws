require 'helper'
require 'aws_network_firewall_logging_configuration'
require 'aws-sdk-core'

class AWSNetworkFirewallLoggingConfigurationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSNetworkFirewallLoggingConfiguration.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSNetworkFirewallLoggingConfiguration.new(firewall_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSNetworkFirewallLoggingConfiguration.new(unexpected: 9) }
  end
end

class AWSNetworkFirewallLoggingConfigurationSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_logging_configuration
    mock_data = {}
    mock_data[:firewall_arn] = 'test1'
    data[:data] = mock_data
    data[:client] = Aws::NetworkFirewall::Client
    @resp = AWSNetworkFirewallLoggingConfiguration.new(firewall_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_configs_exists
    assert @resp.exists?
  end

  def test_firewall_arn
    assert_equal(@resp.firewall_arn,  'test1')
  end
end