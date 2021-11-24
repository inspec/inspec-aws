require 'helper'
require 'aws_cloudwatch_anomaly_detectors'
require 'aws-sdk-core'

class AWSCloudWatchAnomalyDetectorsConstructorTest < Minitest::Test

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudwatchAnomalyDetectors.new(unexpected: 9) }
  end
end

class AWSCloudWatchAnomalyDetectorsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_anomaly_detectors
    mock_data = {}
    mock_data[:namespace] = 'test1'
    mock_data[:metric_name] = 'test1'
    mock_data[:dimensions] = []
    mock_data[:stat] = 'test1'
    mock_data[:configuration] = {}
    mock_data[:state_value] = 'test1'
    data[:data] = { :anomaly_detectors => [mock_data] }
    data[:client] = Aws::CloudWatch::Client
    @resp = AwsCloudwatchAnomalyDetectors.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_namespaces
    assert_equal(@resp.namespaces, ['test1'])
  end

  def test_metric_names
    assert_equal(@resp.metric_names, ['test1'])
  end

  def test_dimensions
    assert_equal(@resp.dimensions, [[]])
  end

  def test_stats
    assert_equal(@resp.stats, ['test1'])
  end

  def test_state_values
    assert_equal(@resp.state_values, ['test1'])
  end
end