require 'helper'
require 'aws_cloudwatch_metric_streams'
require 'aws-sdk-core'

class AWSCloudwatchMetricStreamsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCloudwatchMetricStreams.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudwatchMetricStreams.new('rubbish') }
  end

  def test_metric_streams_non_existing_for_empty_response
    refute AWSCloudwatchMetricStreams.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudwatchMetricStreamsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_metric_streams
    mock_cloudwatch_metric_streams = {}
    mock_cloudwatch_metric_streams[:name] = 'test-name'
    mock_cloudwatch_metric_streams[:arn] = 'test-arn'
    mock_cloudwatch_metric_streams[:firehose_arn] = 'test-arn'
    another_mock_cloudwatch_metric_streams = {}
    another_mock_cloudwatch_metric_streams[:name] = 'test-name'
    another_mock_cloudwatch_metric_streams[:arn] = 'test-arn'
    another_mock_cloudwatch_metric_streams[:firehose_arn] = 'test-arn'
    data[:data] = { :entries => [mock_cloudwatch_metric_streams, another_mock_cloudwatch_metric_streams] }
    data[:client] = Aws::CloudWatch::Client
    @resp = AWSCloudwatchMetricStreams.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_metric_streams_exists
    assert @resp.exist?
  end

  def test_metric_streams_count
    assert_equal(@resp.names.count, 2)
  end

  def test_metric_streams_names
    assert_equal(@resp.names, %w[test-name test-name])
  end

  def test_metric_streams_arns
    assert_equal(@resp.arns, %w[test-arn test-arn])
  end

  def test_metric_streams_firehose_arns
    assert_equal(@resp.firehose_arns, %w[test-arn test-arn])
  end
end