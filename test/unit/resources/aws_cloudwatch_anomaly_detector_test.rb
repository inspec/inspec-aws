require 'helper'
require 'aws_cloudwatch_anomaly_detector'
require 'aws-sdk-core'

class AWSCloudWatchAnomalyDetectorConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsCloudwatchAnomalyDetector.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsCloudwatchAnomalyDetector.new(metric_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudwatchAnomalyDetector.new(unexpected: 9) }
  end
end

class AWSCloudWatchAnomalyDetectorSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_anomaly_detectors
    mock_data = {}
    mock_data[:namespace] = 'test1'
    mock_data[:metric_name] = 'test1'
    mock_data[:dimensions] = [
      name: 'test1',
      value: 'test1'
    ]
    mock_data[:stat] = 'test1'
    mock_data[:configuration] = {}
    mock_data[:state_value] = 'test1'
    data[:data] = { :anomaly_detectors => [mock_data] }
    data[:client] = Aws::CloudWatch::Client
    @resp = AwsCloudwatchAnomalyDetector.new(metric_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_anomaly_detectors_exists
    assert @resp.exists?
  end

  def test_namespace
    assert_equal(@resp.namespace, 'test1')
  end

  def test_metric_name
    assert_equal(@resp.metric_name, 'test1')
  end

  def test_name
    assert_equal(@resp.dimensions[0].name, 'test1')
  end

  def test_value
    assert_equal(@resp.dimensions[0].value, 'test1')
  end

  def test_stat
    assert_equal(@resp.stat, 'test1')
  end

  def test_configuration
    assert_equal(@resp.configuration, {})
  end

  def test_state_value
    assert_equal(@resp.state_value, 'test1')
  end
end