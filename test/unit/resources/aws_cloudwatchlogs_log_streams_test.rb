require 'helper'
require 'aws_cloudwatchlogs_log_streams'
require 'aws-sdk-core'

class AWSCloudWatchLogsLogStreamsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCloudWatchLogsLogStreams.new(log_group_name: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudWatchLogsLogStreams.new('rubbish') }
  end

  def test_job_definitions_non_existing_for_empty_response
    refute AWSCloudWatchLogsLogStreams.new(log_group_name: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudWatchLogsLogStreamsHappyPathTest < Minitest::Test

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
    @resp = AWSCloudWatchLogsLogStreams.new(log_group_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_log_streams_exists
    assert @resp.exists?
  end

  def test_log_stream_names
    assert_equal(@resp.log_stream_names, ['test1'])
  end

  def test_first_event_timestamps
    assert_equal(@resp.first_event_timestamps, [1])
  end

  def test_last_event_timestamps
    assert_equal(@resp.last_event_timestamps, [1])
  end

  def test_last_ingestion_time
    assert_equal(@resp.last_ingestion_time, [1])
  end

  def test_arns
    assert_equal(@resp.arns, ['test1'])
  end
end