require 'helper'
require 'aws_cloudwatchlogs_subscription_filters'
require 'aws-sdk-core'

class AWSCloudWatchLogsSubscriptionFiltersConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCloudWatchLogsSubscriptionFilters.new(log_group_name: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudWatchLogsSubscriptionFilters.new('rubbish') }
  end

  def test_subscription_filter_non_existing_for_empty_response
    refute AWSCloudWatchLogsSubscriptionFilters.new(log_group_name: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudWatchLogsSubscriptionFiltersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_subscription_filters
    mock_parameter = {}
    mock_parameter[:filter_name] = 'test1'
    mock_parameter[:log_group_name] = 'test1'
    mock_parameter[:filter_pattern] = 'test1'
    mock_parameter[:destination_arn] = 'test1'
    mock_parameter[:role_arn] = 'test1'
    data[:data] = { subscription_filters: [mock_parameter] }
    data[:client] = Aws::CloudWatchLogs::Client
    @resp = AWSCloudWatchLogsSubscriptionFilters.new(log_group_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_subscription_filters
    assert @resp.exists?
  end

  def test_filter_names
    assert_equal(@resp.filter_names, ['test1'])
  end

  def test_log_group_name
    assert_equal(@resp.log_group_names, ['test1'])
  end

  def test_filter_pattern
    assert_equal(@resp.filter_patterns, ['test1'])
  end

  def test_destination_arn
    assert_equal(@resp.destination_arns, ['test1'])
  end

  def test_role_arn
    assert_equal(@resp.role_arns, ['test1'])
  end
end
