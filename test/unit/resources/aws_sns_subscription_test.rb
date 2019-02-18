require 'helper'
require 'aws_sns_subscription'
require 'aws-sdk-core'

class AwsSnsSubscriptionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsSnsSubscription.new }
  end

  def test_rejects_invalid_args
    assert_raises(ArgumentError) { AwsSnsSubscription.new(rubbish: 'rubbish') }
  end

  def test_accepts_subscription_arn
    AwsSnsSubscription.new(subscription_arn: 'arn:aws:sns:us-west-2:0123456789012:my-topic2:8a21d249-4329-4871-acc6-7be709c6ea7f', client_args: { stub_responses: true })
  end
end

class AwsSnsSubscriptionSQSPositiveTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_subscription_attributes
    sns_subscription = {}
    sns_subscription["Owner"] = '123456789123'
    sns_subscription["ConfirmationWasAuthenticated"] = 'true'
    sns_subscription["RawMessageDelivery"] = 'true'
    sns_subscription["TopicArn"] = 'arn:aws:sns:us-west-2:0123456789012:aws-sns-topic-arn-yqcaaklkcomfhhpegznykagjk'
    sns_subscription["Endpoint"] = 'arn:aws:sns:us-west-2:0123456789012:aws-sns-topic-endpoint-sqs-auzoitotenajpdiftuiorkmrf'
    sns_subscription["Protocol"] = 'sqs'
    data[:data] = OpenStruct.new({ :attributes => sns_subscription })
    data[:client] = Aws::SNS::Client
    @sns_subscription = AwsSnsSubscription.new(subscription_arn: 'arn:aws:sns:us-west-2:0123456789012:aws-sns-subscription-auzoitotenajpdiftuiorkmrf', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_sns_subscription_exists
    assert @sns_subscription.exists?
  end

  def test_sns_subscription_owner
    assert_equal(@sns_subscription.owner, '123456789123')
  end

  def test_sns_subscription_topic
    assert_equal(@sns_subscription.topic_arn, 'arn:aws:sns:us-west-2:0123456789012:aws-sns-topic-arn-yqcaaklkcomfhhpegznykagjk')
  end

  def test_sns_subscription_Endpoint
    assert_equal(@sns_subscription.endpoint, 'arn:aws:sns:us-west-2:0123456789012:aws-sns-topic-endpoint-sqs-auzoitotenajpdiftuiorkmrf')
  end

  def test_sns_subscription_Protocol
    assert_equal(@sns_subscription.protocol, 'sqs')
  end

  def test_sns_subscription_raw_message_delivery
    assert(@sns_subscription.raw_message_delivery?)
  end

  def test_sns_subscription_PendingConfirmation
    assert(@sns_subscription.confirmation_authenticated?)
  end
end

class AwsSnsSubscriptionEmailNegativeTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_subscription_attributes
    sns_subscription = {}
    sns_subscription["Owner"] = '123456789123'
    sns_subscription["ConfirmationWasAuthenticated"] = 'false'
    sns_subscription["RawMessageDelivery"] = 'false'
    sns_subscription["TopicArn"] = 'arn:aws:sns:us-west-2:0123456789012:aws-sns-topic-arn-yqcaaklkcomfhhpegznykagjk'
    sns_subscription["Endpoint"] = 'snsmail@notreal.com'
    sns_subscription["Protocol"] = 'email'
    data[:data] = OpenStruct.new({ :attributes => sns_subscription })
    data[:client] = Aws::SNS::Client
    @sns_subscription = AwsSnsSubscription.new(subscription_arn: 'arn:aws:sns:us-west-2:0123456789012:aws-sns-subscription-auzoitotenajpdiftuiorkmrf', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_sns_subscription_exists
    assert @sns_subscription.exists?
  end

  def test_sns_subscription_owner
    assert_equal(@sns_subscription.owner, '123456789123')
  end

  def test_sns_subscription_topic
    assert_equal(@sns_subscription.topic_arn, 'arn:aws:sns:us-west-2:0123456789012:aws-sns-topic-arn-yqcaaklkcomfhhpegznykagjk')
  end

  def test_sns_subscription_Endpoint
    assert_equal(@sns_subscription.endpoint, 'snsmail@notreal.com')
  end

  def test_sns_subscription_Protocol
    assert_equal(@sns_subscription.protocol, 'email')
  end

  def test_sns_subscription_raw_message_delivery
    refute(@sns_subscription.raw_message_delivery?)
  end

  def test_sns_subscription_PendingConfirmation
    refute(@sns_subscription.confirmation_authenticated?)
  end
end