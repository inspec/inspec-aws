require 'helper'
require 'aws_rds_event_subscription'
require 'aws-sdk-core'

class AWSRDSEventSubscriptionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRDSEventSubscription.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRDSEventSubscription.new(subscription_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRDSEventSubscription.new(unexpected: 9) }
  end
end

class AWSRDSEventSubscriptionSuccessPathTest < Minitest::Test

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
    @resp = AWSRDSEventSubscription.new( subscription_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_event_subscription_exist
    assert @resp.exists?
  end

  def test_customer_aws_id
    assert_equal(@resp.customer_aws_id, 'test1')
  end

  def test_cust_subscription_id
    assert_equal(@resp.cust_subscription_id, 'test1')
  end

  def test_sns_topic_arn
    assert_equal(@resp.sns_topic_arn, 'test1')
  end

  def test_status
    assert_equal(@resp.status, 'test1')
  end
end 
