require 'helper'
require 'aws_cloudwatch_log_metric_filter'
require 'aws-sdk-core'

class AwsCloudwatchLogMetricFilterConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsCloudwatchLogMetricFilter.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsCloudwatchLogMetricFilter.new('rubbish') }
  end

  def test_accepts_ok_params
    AwsCloudwatchLogMetricFilter.new(filter_name: 'filter-1234abcd', client_args: { stub_responses: true })
    AwsCloudwatchLogMetricFilter.new(pattern: '1234abcd', client_args: { stub_responses: true })
    AwsCloudwatchLogMetricFilter.new(log_group_name: 'loggroup', client_args: { stub_responses: true })
  end

  def test_rejects_invalid_param
    assert_raises(ArgumentError) { AwsCloudwatchLogMetricFilter.new(blah: 'logmetricfilter-rubbish') }
  end

  def test_log_metric_filter_non_existing
    refute AwsCloudwatchLogMetricFilter.new(pattern: 'lmf-1234abcd', client_args: { stub_responses: true }).exists?
    refute AwsCloudwatchLogMetricFilter.new(filter_name: 'lmf-1234abcd', client_args: { stub_responses: true }).exists?
    refute AwsCloudwatchLogMetricFilter.new(log_group_name: 'lmf-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsCloudwatchLogMetricFilterHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_metric_filters
    log_metric = {}
    log_metric[:filter_name] = 'lmf-test'
    log_metric[:filter_pattern] = 'PATTERN'
    log_metric[:log_group_name] = 'log-group'
    log_metric[:metric_transformations] = [{ metric_name: 'metric', metric_value: '0', metric_namespace: 'namespace' }]
    data[:data] = { :metric_filters => [log_metric] }
    data[:client] = Aws::CloudWatchLogs::Client
    @log_metric_filter = AwsCloudwatchLogMetricFilter.new(filter_name: 'lmf-test', log_group_name: 'log-group', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_log_metric_filter_exists
    assert @log_metric_filter.exists?
  end

  def test_log_metric_filter_name
    assert_equal(@log_metric_filter.filter_name, 'lmf-test')
  end

  def test_log_metric_filter_pattern
    assert_equal(@log_metric_filter.pattern, 'PATTERN')
  end

  def test_log_metric_filter_group
    assert_equal(@log_metric_filter.log_group_name, 'log-group')
  end

  def test_log_metric_filter_metric_name
    assert_equal(@log_metric_filter.metric_name, 'metric')
  end

  def test_log_metric_filter_metric_namespace
    assert_equal(@log_metric_filter.metric_namespace, 'namespace')
  end
end

class AwsCloudwatchLogMetricFilterDuplicatesTest < Minitest::Test

  def setup
    @data = {}
    @data[:method] = :describe_metric_filters
    log_metric = {}
    log_metric[:filter_name] = 'lmf-test'
    log_metric[:filter_pattern] = 'PATTERN'
    log_metric[:log_group_name] = 'log-group'
    log_metric[:metric_transformations] = [{ metric_name: 'metric', metric_value: '0', metric_namespace: 'namespace' }]
    duplicate = {}
    duplicate[:filter_name] = 'lmf-test'
    duplicate[:filter_pattern] = 'DIFFERENT_PATTERN'
    duplicate[:log_group_name] = 'log-group'
    duplicate[:metric_transformations] = [{ metric_name: 'metric', metric_value: '0', metric_namespace: 'namespace' }]
    @data[:data] = { :metric_filters => [log_metric, duplicate] }
    @data[:client] = Aws::CloudWatchLogs::Client
  end

  def test_log_metric_filter_exists
    assert_raises(RuntimeError) do
      AwsCloudwatchLogMetricFilter.new(log_group_name: 'log-group', client_args: { stub_responses: true }, stub_data: [@data])
    end
  end

  def test_log_metric_filter_pattern_filtering
    @log_metric_filter = AwsCloudwatchLogMetricFilter.new(log_group_name: 'log-group', pattern: 'DIFFERENT_PATTERN', client_args: { stub_responses: true }, stub_data: [@data])
    assert @log_metric_filter.exists?
  end
end
