require 'helper'
require 'aws_cloudwatch_insight_rules'
require 'aws-sdk-core'

class AWSCloudwatchInsightRulesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCloudwatchInsightRules.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudwatchInsightRules.new('rubbish') }
  end

  def test_rules_non_existing_for_empty_response
    refute AWSCloudwatchInsightRules.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudwatchInsightRulesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_insight_rules
    mock_cloudwatch_rules = {}
    mock_cloudwatch_rules[:name] = 'test-name'
    mock_cloudwatch_rules[:state] = 'test-state'
    mock_cloudwatch_rules[:schema] = 'test-schemas'
    mock_cloudwatch_rules[:definition] = 'test-definition'
    another_mock_cloudwatch_rules = {}
    another_mock_cloudwatch_rules[:name] = 'test-name'
    another_mock_cloudwatch_rules[:state] = 'test-state'
    another_mock_cloudwatch_rules[:schema] = 'test-schemas'
    another_mock_cloudwatch_rules[:definition] = 'test-definition'
    data[:data] = { :insight_rules => [mock_cloudwatch_rules, another_mock_cloudwatch_rules] }
    data[:client] = Aws::CloudWatch::Client
    @resp = AWSCloudwatchInsightRules.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_rules_exists
    assert @resp.exist?
  end

  def test_rules_count
    assert_equal(@resp.names.count, 2)
  end

  def test_rules_names
    assert_equal(@resp.names, %w[test-name test-name])
  end

  def test_rules_states
    assert_equal(@resp.states, %w[test-state test-state])
  end

  def test_rules_schemas
    assert_equal(@resp.schemas, %w[test-schemas test-schemas])
  end

  def test_rules_definitions
    assert_equal(@resp.definitions, %w[test-definition test-definition])
  end
end
