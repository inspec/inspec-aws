require 'helper'
require 'aws_mq_configuration'
require 'aws-sdk-core'

class AWSMQConfigurationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSMQConfiguration.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSMQConfiguration.new(configuration_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSMQConfiguration.new(unexpected: 9) }
  end
end

class AWSMQConfigurationSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_configuration
    mock_parameter = {}
    mock_parameter[:arn] = 'test1'
    mock_parameter[:id] = 'test1'
    mock_parameter[:name] = 'test1'
    mock_parameter[:engine_version] = 'test1'
    data[:data] = mock_parameter
    data[:client] = Aws::MQ::Client
    @mq_configurations = AWSMQConfiguration.new(configuration_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_mq_configurations_exists
    assert @mq_configurations.exists?
  end

  def test_mq_configurations_arn
    assert_equal(@mq_configurations.arn, 'test1')
  end

  def test_mq_configurations_name
    assert_equal(@mq_configurations.name, 'test1')
  end
end

