require 'helper'
require 'aws_cloudwatch_log_group'
require 'aws-sdk-core'

class AwsCloudWatchLogGroupContructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsCloudWatchLogGroup.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudWatchLogGroup.new(rubbish: 99) }
  end

  def test_rejects_empty_name
    assert_raises(ArgumentError) { AwsCloudWatchLogGroup.new(log_group_name: '') }
  end

  def test_log_group_non_existing
    refute AwsCloudWatchLogGroup.new(log_group_name: 'my_log_group', client_args: { stub_responses: true }).exists?
  end
end

class AwsCloudWatchLogGroupConstructorSingleMatchTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_log_groups
    data[:data] = {
      :log_groups => [
        {
          :log_group_name => 'my_log_group',
          :creation_time => 1522855542366,
          :metric_filter_count => 0,
          :arn => 'arn:aws:logs:eu-west-1:111111111111:log-group:my_log_group:*',
          :stored_bytes => 0,
        }
      ]
    }

    data[:client] = Aws::CloudWatchLogs::Client

    tags_data = {}
    tags_data[:method] = :list_tags_log_group
    tags_data[:data] = {
      :tags => {}
    }
    tags_data[:client] = Aws::CloudWatchLogs::Client
    @log_group = AwsCloudWatchLogGroup.new(log_group_name: 'my_log_group', client_args: { stub_responses: true }, stub_data: [data, tags_data])
  end

  def test_log_group_exists
    assert @log_group.exists?
  end

  def test_log_group_name
    assert_equal(@log_group.log_group_name, 'my_log_group')
  end

  def test_log_group_empty_retention_in_days
    assert_nil(@log_group.retention_in_days)
  end

  def test_log_group_empty_kms_key_id
    assert_nil(@log_group.kms_key_id)
  end

  def test_log_group_metric_filter_count
    assert_equal(@log_group.metric_filter_count, 0)
  end

  def test_log_group_tags
    assert_equal(@log_group.tags, {})
  end
end

class AwsCloudWatchLogGroupConstructorWithExtraTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_log_groups
    data[:data] = {
      :log_groups => [
        {
          :log_group_name => 'my_log_group_with_extra',
          :creation_time => 1522855542366,
          :metric_filter_count => 10,
          :arn => 'arn:aws:logs:eu-west-1:111111111111:log-group:my_log_group_with_extra:*',
          :stored_bytes => 0,
          :kms_key_id => 'arn:aws:kms:eu-west-1:111111111111:key/3c1a99bf-4d52-467f-914e-b96a1416ad4e',
          :retention_in_days => 7
        }
      ]
    }

    data[:client] = Aws::CloudWatchLogs::Client

    tags_data = {}
    tags_data[:method] = :list_tags_log_group
    tags_data[:data] = {
      :tags => {
        'tag1' => 'value1',
        'tag2' => 'value2'
      }
    }
    tags_data[:client] = Aws::CloudWatchLogs::Client
    @log_group = AwsCloudWatchLogGroup.new(log_group_name: 'my_log_group_with_extra', client_args: { stub_responses: true }, stub_data: [data, tags_data])
  end

  def test_log_group_exists
    assert @log_group.exists?
  end

  def test_log_group_name
    assert_equal(@log_group.log_group_name, 'my_log_group_with_extra')
  end

  def test_log_group_empty_retention_in_days
    assert_equal(@log_group.retention_in_days, 7)
  end

  def test_log_group_empty_kms_key_id
    assert_equal(@log_group.kms_key_id, 'arn:aws:kms:eu-west-1:111111111111:key/3c1a99bf-4d52-467f-914e-b96a1416ad4e')
  end

  def test_log_group_metric_filter_count
    assert_equal(@log_group.metric_filter_count, 10)
  end

  def test_log_group_tags
    assert_equal(@log_group.tags, {
      'tag1' => 'value1',
      'tag2' => 'value2'
    })
  end
end

class AwsCloudWatchLogGroupConstructorMultipleFound < Minitest::Test
  def setup
    @data = {}
    @data[:method] = :describe_log_groups
    @data[:data] = {
      :log_groups => [
        {
          :log_group_name => 'my_log_group',
          :creation_time => 1522855542366,
          :metric_filter_count => 0,
          :arn => 'arn:aws:logs:eu-west-1:111111111111:log-group:my_log_group:*',
          :stored_bytes => 0,
        },
        {
          :log_group_name => 'my_log_group_with_extra',
          :creation_time => 1522855542366,
          :metric_filter_count => 10,
          :arn => 'arn:aws:logs:eu-west-1:111111111111:log-group:my_log_group_with_extra:*',
          :stored_bytes => 0,
          :kms_key_id => 'arn:aws:kms:eu-west-1:111111111111:key/3c1a99bf-4d52-467f-914e-b96a1416ad4e',
          :retention_in_days => 7
        }
      ]
    }

    @data[:client] = Aws::CloudWatchLogs::Client
  end

  def test_multiple_log_groups_returned_fails
    assert_raises(RuntimeError) { AwsCloudWatchLogGroup.new(log_group_name: 'my_log_group', client_args: { stub_responses: true }, stub_data: [@data]) }
  end
end
