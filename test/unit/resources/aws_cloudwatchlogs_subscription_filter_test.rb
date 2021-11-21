require 'helper'
require 'aws_cloudwatchlogs_subscription_filter'
require 'aws-sdk-core'

class AWSCloudWatchLogsSubscriptionFilterConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudWatchLogsSubscriptionFilter.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudWatchLogsSubscriptionFilter.new(log_group_name: '', log_stream_name_prefix: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudWatchLogsSubscriptionFilter.new(unexpected: 9) }
  end
end

class AWSCloudWatchLogsSubscriptionFilterSuccessPathTest < Minitest::Test

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
    @resp = AWSCloudWatchLogsSubscriptionFilter.new(log_group_name: 'test1', filter_name_prefix: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_subscription_filters_exists
    assert @resp.exists?
  end

  def test_filter_name
    assert_equal(@resp.filter_name, 'test1')
  end

  def test_log_group_name
    assert_equal(@resp.log_group_name, 'test1')
  end

  def test_filter_pattern
    assert_equal(@resp.filter_pattern, 'test1')
  end

  def test_destination_arn
    assert_equal(@resp.destination_arn, 'test1')
  end

  def test_role_arn
    assert_equal(@resp.role_arn, 'test1')
  end
end 
