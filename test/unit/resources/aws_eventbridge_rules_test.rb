require 'helper'
require 'aws_eventbridge_rules'
require 'aws-sdk-core'

class AWSEventBridgeRulesConstructorTest < Minitest::Test

  def test_empty_params_argument_error_check
    assert_raises(ArgumentError)  {AWSEventBridgeRules.new(name_prefix: '', client_args: { stub_responses: true })}
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEventBridgeRules.new('rubbish') }
  end
end

class AWSEventBridgeRulesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_rules
    mock_data = {}
    mock_data[:name] = 'test1'
    mock_data[:arn] = 'test1'
    mock_data[:event_pattern] = 'test1'
    data[:data] = { :rules => [mock_data] }
    data[:client] = Aws::EventBridge::Client
    @resp = AWSEventBridgeRules.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_rules_exists
    assert @resp.exist?
  end

  def test_names
    assert_equal(@resp.names, ['test1'])
  end

  def test_states
    assert_equal(@resp.arns, ['test1'])
  end

  def test_event_patterns
    assert_equal(@resp.event_patterns, ['test1'])
  end
end