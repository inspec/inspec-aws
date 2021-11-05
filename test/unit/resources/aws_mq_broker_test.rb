require 'helper'
require 'aws_mq_broker'
require 'aws-sdk-core'

class AWSMQBrokerConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSMQBroker.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSMQBroker.new(broker_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSMQBroker.new(unexpected: 9) }
  end
end

class AWSMQBrokerSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_broker
    mock_parameter = {}
    mock_parameter[:broker_arn] = 'test1'
    mock_parameter[:broker_id] = 'test1'
    mock_parameter[:broker_name] = 'test1'
    mock_parameter[:broker_state] = 'test1'
    data[:data] = mock_parameter
    data[:client] = Aws::MQ::Client
    @mq_broker = AWSMQBroker.new(broker_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_mq_broker_exists
    assert @mq_broker.exists?
  end

  def test_mq_broker_arn
    assert_equal(@mq_broker.broker_arn, 'test1')
  end

  def test_mq_broker_name
    assert_equal(@mq_broker.broker_name, 'test1')
  end
end
