require 'helper'
require 'aws_cloudwatchlogs_log_stream'
require 'aws-sdk-core'

class AWSCloudWatchLogsLogStreamConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudWatchLogsLogStream.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudWatchLogsLogStream.new(log_group_name: '', log_stream_name_prefix: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudWatchLogsLogStream.new(unexpected: 9) }
  end
end

class AWSCloudWatchLogsLogStreamSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_log_streams
    mock_parameter = {}
    mock_parameter[:log_stream_name] = 'test1'
    mock_parameter[:first_event_timestamp] = 1
    mock_parameter[:last_event_timestamp] = 1
    mock_parameter[:last_ingestion_time] = 1
    mock_parameter[:arn] = 'test1'
    data[:data] = { log_streams: [mock_parameter] }
    data[:client] = Aws::CloudWatchLogs::Client
    @resp = AWSCloudWatchLogsLogStream.new(log_group_name: 'test1', log_stream_name_prefix: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_log_streams_exists
    assert @resp.exists?
  end

  def test_log_stream_name
    assert_equal(@resp.log_stream_name, 'test1')
  end

  def test_first_event_timestamp
    assert_equal(@resp.first_event_timestamp, 1)
  end

  def test_last_event_timestamp
    assert_equal(@resp.last_event_timestamp, 1)
  end

  def test_last_ingestion_time
    assert_equal(@resp.last_ingestion_time, 1)
  end

  def test_arn
    assert_equal(@resp.arn, 'test1')
  end
end