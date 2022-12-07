require 'helper'
require 'aws_eventbridge_rule'
require 'aws-sdk-core'

class AWSEventBridgeRuleConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEventBridgeRule.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEventBridgeRule.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEventBridgeRule.new(unexpected: 9) }
  end
end

class AWSEventBridgeRuleSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_rule
    mock_parameter = {}
    mock_parameter[:name] = 'test1'
    mock_parameter[:arn] = 'test1'
    mock_parameter[:state] = 'test1'
    data[:data] = mock_parameter
    data[:client] = Aws::EventBridge::Client
    @res = AWSEventBridgeRule.new(name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_event_rule_exists
    assert @res.exists?
  end

  def test_name
    assert_equal(@res.name, 'test1')
  end

  def test_arn
    assert_equal(@res.arn, 'test1')
  end

  def test_state
    assert_equal(@res.state, 'test1')
  end

  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, 'test1')
  end
end