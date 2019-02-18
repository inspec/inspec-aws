require 'helper'
require 'aws_sns_topic'
require 'aws-sdk-core'

class AwsSnsTopicConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsSnsTopic.new }
  end

  def test_rejects_invalid_args
    assert_raises(ArgumentError) { AwsSnsTopic.new(rubbish: 'rubbish') }
  end

  def test_constructor_rejects_non_arn_formats
    [
        'not-even-like-an-arn',
        'arn:::::', # Empty
        'arn::::::', # Too many colons
        'arn:aws::us-east-1:123456789012:some-topic', # Omits SNS service
        'arn::sns:us-east-1:123456789012:some-topic', # Omits partition
        'arn:aws:sns:*:123456789012:some-topic', # All-region - not permitted for lookup
        'arn:aws:sns:us-east-1::some-topic', # Default account - not permitted for lookup
    ].each do |example|
      assert_raises(ArgumentError) { AwsSnsTopic.new(arn: example) }
    end
  end
end

class AwsSnsTopicNonExistingTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_topic_attributes
    data[:data] = Aws::SNS::Errors::NotFound.new(nil, nil)
    data[:client] = Aws::SNS::Client
    @sns_topic = AwsSnsTopic.new(arn: 'arn:aws:sns:us-west-2:012345678901:aws-sns-topic-auzoitotenajpdiftuiorkmrf', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_sns_topic_exists
    refute @sns_topic.exists?
  end
end

class AwsSnsTopicSubscriptionTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_topic_attributes
    data[:data] = OpenStruct.new({ :attributes => { "SubscriptionsConfirmed" => "1" } })
    data[:client] = Aws::SNS::Client
    @sns_topic = AwsSnsTopic.new(arn: 'arn:aws:sns:us-west-2:012345678901:aws-sns-topic-auzoitotenajpdiftuiorkmrf', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_sns_topic_exists
    assert @sns_topic.exists?
  end

  def test_sns_topic_confirmed_subscription_count
    assert_equal(1, @sns_topic.confirmed_subscription_count)
  end
end

class AwsSnsTopicTopicNoSubscriptionTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_topic_attributes
    data[:data] = OpenStruct.new({ :attributes => { "SubscriptionsConfirmed" => "0" } })
    data[:client] = Aws::SNS::Client
    @sns_topic = AwsSnsTopic.new(arn: 'arn:aws:sns:us-west-2:012345678901:aws-sns-topic-auzoitotenajpdiftuiorkmrf', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_sns_topic_exists
    assert @sns_topic.exists?
  end

  def test_sns_topic_confirmed_subscription_count
    assert_equal(0, @sns_topic.confirmed_subscription_count)
  end
end