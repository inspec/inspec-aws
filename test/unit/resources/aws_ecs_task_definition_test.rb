require 'helper'
require 'aws_ecs_task_definition'
require 'aws-sdk-core'

class AWSECSTaskDefinitionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSECSTaskDefinition.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSECSTaskDefinition.new(task_definition: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSECSTaskDefinition.new(unexpected: 9) }
  end
end

class AWSECSTaskDefinitionSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_task_definition
    mock_parameter = {}
    mock_parameter[:task_definition_arn] = 'test1'
    mock_parameter[:family] = 'test1'
    mock_parameter[:task_role_arn] = 'test1'
    data[:data] = { task_definition: mock_parameter }
    data[:client] = Aws::ECS::Client
    @task_definition = AWSECSTaskDefinition.new(task_definition: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_group_exists
    assert @task_definition.exists?
  end

  def test_task_definition_arn
    assert_equal(@task_definition.task_definition_arn, 'test1')
  end

  def test_task_role_arn
    assert_equal(@task_definition.task_role_arn, 'test1')
  end

  def test_task_role_arn
    assert_equal(@task_definition.task_role_arn, 'test1')
  end
end