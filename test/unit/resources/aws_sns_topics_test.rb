require 'helper'
require 'aws_sns_topics'
require 'aws-sdk-core'

class AwsSnsTopicsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsSnsTopics.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsSnsTopics.new('rubbish') }
  end

  def test_sns_topics_non_existing_for_empty_response
    refute AwsSnsTopics.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsSnsTopicsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_topics
    topics = []
    topics += [{ :topic_arn => 'arn:aws:sns:us-west-2:012345678901:aws-sns-topic-1-auzoitotenajpdiftuiorkmrf' }]
    topics += [{ :topic_arn => 'arn:aws:sns:us-west-2:012345678901:aws-sns-topic-2-auzoitotenajpdiftuiorkmrf' }]
    data[:data] = { :topics => topics }
    data[:client] = Aws::SNS::Client
    @sns_topics = AwsSnsTopics.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_sns_topics_exists
    assert @sns_topics.exist?
  end

  def test_sns_topics_arns
    assert_equal(@sns_topics.topic_arns, %w(arn:aws:sns:us-west-2:012345678901:aws-sns-topic-1-auzoitotenajpdiftuiorkmrf
                                                arn:aws:sns:us-west-2:012345678901:aws-sns-topic-2-auzoitotenajpdiftuiorkmrf))
  end
end