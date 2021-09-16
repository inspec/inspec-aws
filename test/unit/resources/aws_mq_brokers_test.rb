require 'helper'
require 'aws_mq_brokers'
require 'aws-sdk-core'

class AWSMQBrokersConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSMQBrokers.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSMQBrokers.new(broker_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSMQBrokers.new(unexpected: 9) }
  end
end

class AWSMQBrokersSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_broker
    mock_parameter = {}
    mock_parameter[:broker_arn] = 'test1'
    mock_parameter[:broker_id] = 'test1'
    mock_parameter[:broker_name] = 'test1'
    mock_parameter[:broker_state] = 'test1'
    data[:data] = { job_definitions: [mock_parameter] }
    data[:client] = Aws::MQ::Client
    @mq_broker = AWSMQBrokers.new( client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_job_definitions_exists
    assert @mq_broker.exists?
  end

  def test_job_definition_name
    assert_equal(@mq_broker.broker_arns, 'test1')
  end

  def test_revision
    assert_equal(@mq_broker.revisions, 'test1')
  end
end

