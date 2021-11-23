require 'helper'
require 'aws_cloudwatch_metric_stream'
require 'aws-sdk-core'

class AWSCloudwatchMetricStreamConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudwatchMetricStream.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudwatchMetricStream.new(metric_stream_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudwatchMetricStream.new(unexpected: 9) }
  end
end

class AWSCloudwatchMetricStreamHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_metric_stream
    mock_cloudwatch_metric_stream = {}
    mock_cloudwatch_metric_stream[:name] = 'test-name'
    mock_cloudwatch_metric_stream[:arn] = 'test-arn'
    mock_cloudwatch_metric_stream[:firehose_arn] = "test-arn"
    data[:data] = mock_cloudwatch_metric_stream
    data[:client] = Aws::CloudWatch::Client
    @resp = AWSCloudwatchMetricStream.new(metric_stream_name: 'test-name', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_metric_stream_exists
    assert @resp.exist?
  end

  def test_metric_stream_name
    assert_equal(@resp.name, 'test-name')
  end

  def test_metric_stream_arn
    assert_equal(@resp.arn, 'test-arn')
  end

  def test_firehose_arn
    assert_equal(@resp.firehose_arn, 'test-arn')
  end
end
