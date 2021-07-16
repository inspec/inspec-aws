require 'helper'
require 'aws_logs_metric_filter'
require 'aws-sdk-core'

class AWSLogsMetricFiltersConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSLogsMetricFilters.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSLogsMetricFilters.new('rubbish') }
  end

  def test_metric_filters_non_existing_for_empty_response
    refute AWSLogsMetricFilters.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSLogsMetricFiltersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_metric_filters
    mock_data = {}
    mock_data[:filter_name] = 'test1'
    mock_data[:filter_pattern] = 'test1'
    mock_data[:creation_time] = 1
    mock_data[:log_group_name] = 'test1'
    data[:data] = { :metric_filters => [mock_data] }
    data[:client] = Aws::CloudWatchLogs::Client
    @metric_filters = AWSLogsMetricFilters.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_metric_filters_exists
    assert @metric_filters.exist?
  end

  def test_filter_names
    assert_equal(@metric_filters.filter_names, ['test1'])
  end

  def test_filter_patterns
    assert_equal(@metric_filters.filter_patterns, ['test1'])
  end

  def test_creation_times
    assert_equal(@metric_filters.creation_times, [1])
  end

  def test_log_group_names
    assert_equal(@metric_filters.log_group_names, ['test1'])
  end
end