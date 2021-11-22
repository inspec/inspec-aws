require 'helper'
require 'aws_securityhub_hub'
require 'aws-sdk-core'

class AWSSecurityHubHubConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSSecurityHubHub.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSecurityHubHub.new(hub_arn: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSecurityHubHub.new(unexpected: 9) }
  end
end

class AWSSecurityHubHubSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_hub
    mock_parameter = {}
    mock_parameter[:hub_arn] = 'test1'
    mock_parameter[:subscribed_at] = 'test1'
    mock_parameter[:auto_enable_controls] = true
    data[:data] = mock_parameter
    data[:client] = Aws::SecurityHub::Client
    @resp = AWSSecurityHubHub.new(hub_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_security_hub_exists
    assert @resp.exists?
  end

  def test_hub_arn
    assert_equal(@resp.hub_arn, 'test1')
  end

  def test_subscribed_at
    assert_equal(@resp.subscribed_at, 'test1')
  end

  def test_auto_enable_controls
    assert_equal(@resp.auto_enable_controls, true)
  end
end