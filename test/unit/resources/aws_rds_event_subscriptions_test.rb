require 'helper'
require 'aws_rds_event_subscriptions'
require 'aws-sdk-core'

class AWSRDSEventSubscriptionsConstructorTest < Minitest::Test

  def test_non_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRDSEventSubscriptions.new('test', client_args: { stub_responses: true }) }
  end

  def test_rejects_params
    assert_raises(ArgumentError) { AWSRDSEventSubscriptions.new(unexpected: 9) }
  end
end

class AWSRDSEventSubscriptionsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_event_subscriptions
    mock_data = {}
    mock_data[:customer_aws_id] = 'test1'
    mock_data[:cust_subscription_id] = 'test1'
    mock_data[:sns_topic_arn] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:source_type] = 'test1'
    data[:data] = { event_subscriptions_list: [mock_data] }
    data[:client] = Aws::RDS::Client
    @resp = AWSRDSEventSubscriptions.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_event_subscription_exist
    assert @resp.exists?
  end

  def test_customer_aws_ids
    assert_equal(@resp.customer_aws_ids, ['test1'])
  end

  def test_cust_subscription_ids
    assert_equal(@resp.cust_subscription_ids, ['test1'])
  end

  def test_sns_topic_arns
    assert_equal(@resp.sns_topic_arns, ['test1'])
  end

  def test_statuses
    assert_equal(@resp.statuses, ['test1'])
  end
end 