require 'helper'
require 'aws_mq_configurations'
require 'aws-sdk-core'

class AWSMQConfigurationsConstructorTest < Minitest::Test

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSMQConfigurations.new(configurations_id: 'random', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSMQConfigurations.new(unexpected: 9) }
  end
end

class AWSMQConfigurationsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_configurations
    mock_parameter = {}
    mock_parameter[:arn] = 'test1'
    mock_parameter[:id] = 'test1'
    mock_parameter[:name] = 'test1'
    mock_parameter[:engine_version] = 'test1'
    mock_parameter[:authentication_strategy] = 'test1'
    mock_parameter[:created] = Time.now
    mock_parameter[:description] = 'test1'
    mock_parameter[:engine_type] = 'test1'
    mock_parameter[:latest_revision] = { created: Time.now, revision: 2}
    data[:data] = { configurations: [mock_parameter]}
    data[:client] = Aws::MQ::Client
    @mq_configurations = AWSMQConfigurations.new( client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_mq_configurations_exists
    assert @mq_configurations.exists?
  end

  def test_mq_configurations_arn
    assert_equal(@mq_configurations.arns, ['test1'])
  end

  def test_mq_configurations_name
    assert_equal(@mq_configurations.names, ['test1'])
  end
end


