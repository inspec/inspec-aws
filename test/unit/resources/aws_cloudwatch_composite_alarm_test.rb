require 'helper'
require 'aws_cloudwatch_composite_alarm'
require 'aws-sdk-core'

class AWSCloudWatchCompositeAlarmConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsCloudwatchCompositeAlarm.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsCloudwatchCompositeAlarm.new(alarm_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudwatchCompositeAlarm.new(unexpected: 9) }
  end
end

class AWSCloudWatchCompositeAlarmSuccessPathTest < Minitest::Test

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
    @resp = AwsCloudwatchCompositeAlarm.new(alarm_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_event_invoke_config_exists
    assert @resp.exists?
  end

  def test_actions_enabled
    assert_equal(@resp.actions_enabled, true)
  end

  def test_alarm_arn
    assert_equal(@resp.alarm_arn, 'test1')
  end

  def test_alarm_configuration_updated_timestamp
    assert_equal(@resp.alarm_configuration_updated_timestamp, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_alarm_description
    assert_equal(@resp.alarm_description, 'test1')
  end

  def test_alarm_name
    assert_equal(@resp.alarm_name, 'test1')
  end

  def test_alarm_rule
    assert_equal(@resp.alarm_rule, 'test1')
  end

  def test_insufficient_data_actions
    assert_equal(@resp.insufficient_data_actions, ['test1'])
  end

  def test_ok_actions
    assert_equal(@resp.ok_actions, ['test1'])
  end

  def test_state_reason
    assert_equal(@resp.state_reason, 'test1')
  end

  def test_state_reason_data
    assert_equal(@resp.state_reason_data, 'test1')
  end

  def test_state_updated_timestamp
    assert_equal(@resp.state_updated_timestamp, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_state_value
    assert_equal(@resp.state_value, 'test1')
  end
end