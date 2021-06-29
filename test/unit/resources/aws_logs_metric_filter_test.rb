require 'helper'
require 'aws_logs_metric_filters'
require 'aws-sdk-core'

class AWSLogsMetricFilterConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSLogsMetricFilter.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLogsMetricFilter.new(filter_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLogsMetricFilter.new(unexpected: 9) }
  end
end

class AWSLogsMetricFilterSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_metric_filters
    mock_data = {}
    mock_data[:filter_name] = 'test1'
    mock_data[:filter_pattern] = 'test1'
    mock_data[:creation_time] = 1
    mock_data[:log_group_name] = 'test1'
    data[:data] = { metric_filters: [mock_data] }
    data[:client] = Aws::CloudWatchLogs::Client
    @metric_filters = AWSLogsMetricFilter.new(filter_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_metric_filter_exists
    assert @metric_filters.exists?
  end

  def test_filter_name
    assert_equal(@metric_filters.filter_name, 'test1')
  end

  def test_filter_pattern
    assert_equal(@metric_filters.filter_pattern, 'test1')
  end

  def test_creation_time
    assert_equal(@metric_filters.creation_time, 1)
  end

  def test_log_group_name
    assert_equal(@metric_filters.log_group_name, 'test1')
  end
end