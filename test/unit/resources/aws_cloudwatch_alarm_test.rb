require 'helper'
require 'aws_cloudwatch_alarm'
require 'aws-sdk-core'

class AwsCloudwatchAlarmConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsCloudwatchAlarm.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_valid_args
    AwsCloudwatchAlarm.new(metric_name: 'metric', metric_namespace: 'space', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudwatchAlarm.new(rubbish: 9) }
  end

  def test_rejects_only_one_parameter
    assert_raises(ArgumentError) { AwsCloudwatchAlarm.new(metric_name: 'alarm-needs-two-params') }
    assert_raises(ArgumentError) { AwsCloudwatchAlarm.new(metric_namespace: 'alarm-needs-two-params') }
  end

  def test_alarm_non_existing
    refute AwsCloudwatchAlarm.new(metric_name: 'metric', metric_namespace: 'space', client_args: { stub_responses: true }).exists?
  end
end

class AwsCloudwatchAlarmTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_alarms_for_metric
    mock_alarm = {}
    mock_alarm[:alarm_name] = 'alarm-12345678'
    mock_alarm[:metric_name] = 'metric'
    mock_alarm[:namespace] = 'space'
    mock_alarm[:alarm_actions] = []
    data[:data] = { :metric_alarms => [mock_alarm] }
    data[:client] = Aws::CloudWatch::Client
    @metric_alarms = AwsCloudwatchAlarm.new(metric_name: 'metric', metric_namespace: 'space', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@metric_alarms.resource_id)
    assert_equal(@metric_alarms.resource_id, @metric_alarms.metric_name + '_' + @metric_alarms.metric_namespace)
  end

  def test_alarm_exists
    assert @metric_alarms.exists?
  end

  def test_alarm_name
    assert_equal(@metric_alarms.alarm_name, 'alarm-12345678')
  end

  def test_alarm_metric_name
    assert_equal(@metric_alarms.metric_name, 'metric')
  end

  def test_alarm_metric_namespace
    assert_equal(@metric_alarms.metric_namespace, 'space')
  end

  def test_alarm_actions
    assert_equal(@metric_alarms.alarm_actions, [])
  end
end

class AwsCloudwatchAlarmWithActionTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_alarms_for_metric
    mock_alarm = {}
    mock_alarm[:alarm_name] = 'alarm-12345678'
    mock_alarm[:metric_name] = 'metric'
    mock_alarm[:namespace] = 'space'
    mock_alarm[:alarm_actions] = ['arn:aws:sns:us-west-2:0123456789012:aws-sns-arn']
    data[:data] = { :metric_alarms => [mock_alarm] }
    data[:client] = Aws::CloudWatch::Client
    @metric_alarms = AwsCloudwatchAlarm.new(metric_name: 'metric', metric_namespace: 'space', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_alarm_exists
    assert @metric_alarms.exists?
  end

  def test_alarm_name
    assert_equal(@metric_alarms.alarm_name, 'alarm-12345678')
  end

  def test_alarm_metric_name
    assert_equal(@metric_alarms.metric_name, 'metric')
  end

  def test_alarm_metric_namespace
    assert_equal(@metric_alarms.metric_namespace, 'space')
  end

  def test_alarm_actions
    assert_equal(@metric_alarms.alarm_actions, ['arn:aws:sns:us-west-2:0123456789012:aws-sns-arn'])
  end
end

class AwsCloudwatchAlarmMultipleFailsTest < Minitest::Test

  def setup
    @data = {}
    @data[:method] = :describe_alarms_for_metric
    mock_alarm = {}
    mock_alarm[:alarm_name] = 'alarm-12345678'
    mock_alarm[:metric_name] = 'metric'
    mock_alarm[:namespace] = 'space'
    mock_alarm[:alarm_actions] = []
    another_alarm = {}
    another_alarm[:alarm_name] = 'alarm-1234567'
    another_alarm[:metric_name] = 'metric2'
    another_alarm[:namespace] = 'spacey'
    another_alarm[:alarm_actions] = []
    @data[:data] = { :metric_alarms => [mock_alarm, another_alarm] }
    @data[:client] = Aws::CloudWatch::Client
  end

  def test_multiple_alarms_returned_fails
    assert_raises(RuntimeError) { AwsCloudwatchAlarm.new(metric_name: 'metric', metric_namespace: 'space', client_args: { stub_responses: true }, stub_data: [@data]) }
  end
end

class AwsCloudwatchAlarmWithDimensionsTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_alarms_for_metric
    mock_alarm = {}
    mock_alarm[:alarm_name] = 'alarm-12345678'
    mock_alarm[:metric_name] = 'metric'
    mock_alarm[:namespace] = 'space'
    mock_alarm[:dimensions] = [{:name=>'Server', :value=>'Prod'},{:name=>'Domain', :value=>'Frankfurt'}]
    mock_alarm[:alarm_actions] = []
    data[:data] = { :metric_alarms => [mock_alarm] }
    data[:client] = Aws::CloudWatch::Client
    @metric_alarms = AwsCloudwatchAlarm.new(metric_name: 'metric', metric_namespace: 'space', dimensions: [{:name=>'Server', :value=>'Prod'},{:name=>'Domain', :value=>'Frankfurt'}], client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_alarm_exists
    assert @metric_alarms.exists?
  end

  def test_alarm_name
    assert_equal(@metric_alarms.alarm_name, 'alarm-12345678')
  end

  def test_alarm_metric_name
    assert_equal(@metric_alarms.metric_name, 'metric')
  end

  def test_alarm_metric_namespace
    assert_equal(@metric_alarms.metric_namespace, 'space')
  end

  def test_alarm_dimensions
    assert_equal(@metric_alarms.dimensions, [{name:'Server', value:'Prod'},{name:'Domain', value:'Frankfurt'}])
  end

  def test_alarm_actions
    assert_equal(@metric_alarms.alarm_actions, [])
  end
end
