require 'helper'
require 'aws_ecs_task_definitions'
require 'aws-sdk-core'

class AWSECSTaskDefinitionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSECSTaskDefinitions.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSECSTaskDefinitions.new('rubbish') }
  end
end

class AWSECSTaskDefinitionsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_task_definitions
    mock_data = {}
    mock_data[:task_definition_arns] = ['test1']
    data[:data] = [mock_data] 
    data[:client] = Aws::ECS::Client
    @task_definitions = AWSECSTaskDefinitions.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_task_definitions_exists
    assert @task_definitions.exist?
  end

  def test_task_definition_arns
    assert_equal(@task_definitions.task_definition_arns, [['test1']])
  end
end