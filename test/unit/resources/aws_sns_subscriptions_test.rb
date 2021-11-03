require 'helper'
require 'aws_sns_subscriptions'
require 'aws-sdk-core'

class AWSSNSSubscriptionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSSNSSubscriptions.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSSNSSubscriptions.new('rubbish') }
  end

  def test_subscriptions_non_existing_for_empty_response
    refute AWSSNSSubscriptions.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSSNSSubscriptionsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_subscriptions
    mock_data = {}
    mock_data[:subscription_arn] = 'test1'
    mock_data[:owner] = 'test1'
    mock_data[:protocol] = 'test1'
    mock_data[:endpoint] = 'test1'
    mock_data[:topic_arn] = 'test1'
    data[:data] = { :subscriptions => [mock_data] }
    data[:client] = Aws::SNS::Client
    @resp = AWSSNSSubscriptions.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_subscription_arns
    assert_equal(@resp.subscription_arns, ['test1'])
  end

  def test_owners
    assert_equal(@resp.owners, ['test1'])
  end

  def test_protocols
    assert_equal(@resp.protocols, ['test1'])
  end

  def test_endpoints
    assert_equal(@resp.endpoints, ['test1'])
  end

  def test_topic_arns
    assert_equal(@resp.topic_arns, ['test1'])
  end
end