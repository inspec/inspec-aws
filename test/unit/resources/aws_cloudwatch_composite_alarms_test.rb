require 'helper'
require 'aws_cloudwatch_composite_alarms'
require 'aws-sdk-core'

class AWSCloudWatchCompositeAlarmsConstructorTest < Minitest::Test

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudwatchCompositeAlarms.new(unexpected: 9) }
  end
end

class AWSCloudWatchCompositeAlarmsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_alarms
    mock_data = {}
    mock_data[:actions_enabled] = true
    mock_data[:alarm_arn] = 'test1'
    mock_data[:alarm_configuration_updated_timestamp] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:alarm_description] = 'test1'
    mock_data[:alarm_name] = 'test1'
    mock_data[:alarm_rule] = 'test1'
    mock_data[:insufficient_data_actions] = ['test1']
    mock_data[:ok_actions] = ['test1']
    mock_data[:state_reason] = 'test1'
    mock_data[:state_reason_data] = 'test1'
    mock_data[:state_updated_timestamp] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:state_value] = 'test1'
    data[:data] = { :composite_alarms => [mock_data] }
    data[:client] = Aws::CloudWatch::Client
    @resp = AwsCloudwatchCompositeAlarms.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_actions_enabled
    assert_equal(@resp.actions_enabled, [true])
  end

  def test_alarm_arns
    assert_equal(@resp.alarm_arns, ['test1'])
  end

  def test_alarm_configuration_updated_timestamp
    assert_equal(@resp.alarm_configuration_updated_timestamp, [Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_alarm_descriptions
    assert_equal(@resp.alarm_descriptions, ['test1'])
  end

  def test_alarm_names
    assert_equal(@resp.alarm_names, ['test1'])
  end

  def test_alarm_rules
    assert_equal(@resp.alarm_rules, ['test1'])
  end

  def test_insufficient_data_actions
    assert_equal(@resp.insufficient_data_actions, [['test1']])
  end

  def test_ok_actions
    assert_equal(@resp.ok_actions, [['test1']])
  end

  def test_state_reasons
    assert_equal(@resp.state_reasons, ['test1'])
  end

  def test_state_reason_data
    assert_equal(@resp.state_reason_data, ['test1'])
  end

  def test_state_values
    assert_equal(@resp.state_values, ['test1'])
  end
end