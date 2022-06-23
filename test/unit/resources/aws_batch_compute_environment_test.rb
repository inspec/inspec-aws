require 'helper'
require 'aws_batch_compute_environment'
require 'aws-sdk-core'

class AWSBatchComputeEnvironmentConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSBatchComputeEnvironment.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSBatchComputeEnvironment.new(compute_environment_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSBatchComputeEnvironment.new(unexpected: 9) }
  end
end

class AWSBatchComputeEnvironmentSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_compute_environments
    mock_parameter = {}
    mock_parameter[:compute_environment_name] = 'test1'
    mock_parameter[:compute_environment_arn] = 'test1'
    mock_parameter[:ecs_cluster_arn] = 'test1'
    mock_parameter[:type] = 'test1'
    mock_parameter[:state] = 'test1'
    mock_parameter[:status] = 'test1'
    mock_parameter[:status_reason] = 'test1'
    mock_parameter[:service_role] = 'test1'
    data[:data] = { compute_environments: [mock_parameter] }
    data[:client] = Aws::Batch::Client
    @compute_environments = AWSBatchComputeEnvironment.new(compute_environment_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_compute_environment_exists
    assert @compute_environments.exists?
  end

  def test_compute_environment_name
    assert_equal(@compute_environments.compute_environment_name, 'test1')
  end

  def test_compute_environment_arn
    assert_equal(@compute_environments.compute_environment_arn, 'test1')
  end

  def test_ecs_cluster_arn
    assert_equal(@compute_environments.ecs_cluster_arn, 'test1')
  end

  def test_type
    assert_equal(@compute_environments.type, 'test1')
  end

  def test_state
    assert_equal(@compute_environments.state, 'test1')
  end

  def test_status
    assert_equal(@compute_environments.status, 'test1')
  end

  def test_status_reason
    assert_equal(@compute_environments.status_reason, 'test1')
  end

  def test_service_role
    assert_equal(@compute_environments.service_role, 'test1')
  end

  def test_resource_id
    refute_nil(@compute_environments.resource_id)
    assert_equal(@compute_environments.resource_id, 'test1')
  end
end