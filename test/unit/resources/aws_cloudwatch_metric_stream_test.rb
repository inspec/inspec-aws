require 'helper'
require 'aws_cloudwatch_metric_stream'
require 'aws-sdk-core'

class AWSCloudwatchMetricStreamConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudwatchMetricStream.new(client_args: { stub_responses: true })}
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudwatchMetricStream.new( board: 'rubbish') }
  end

  def testmetric_stream_non_existing_for_empty_response
    refute AWSCloudwatchMetricStream.new(metric_stream_name: 'test-name2' ,client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudwatchMetricStreamHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_metric_stream
    mock_cloudwatch_metric_stream = {}
    mock_cloudwatch_metric_stream[:name] = 'test-name'
    mock_cloudwatch_metric_stream[:arn] = 'test-arn'
    mock_cloudwatch_metric_stream[:firehose_arn] = "test-body"
    data[:data] = mock_cloudwatch_metric_stream
    data[:client] = Aws::CloudWatch::Client
    @metric_streams = AWSCloudwatchMetricStream.new(metric_stream_name: 'test-name' , client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_metric_stream_exists
    assert @metric_streams.exist?
  end

  def test_metric_stream_name
    assert_equal(@metric_streams.name, 'test-name')
  end

  def test_metric_stream_arn
    assert_equal(@metric_streams.arn, 'test-arn')
  end
end