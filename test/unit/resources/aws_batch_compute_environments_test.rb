require 'helper'
require 'aws_batch_compute_environments'
require 'aws-sdk-core'

class AWSBatchComputeEnvironmentsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSBatchComputeEnvironments.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSBatchComputeEnvironments.new('rubbish') }
  end

  def test_compute_environments_non_existing_for_empty_response
    refute AWSBatchComputeEnvironments.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSBatchComputeEnvironmentsHappyPathTest < Minitest::Test

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
    data[:data] = { :compute_environments => [mock_parameter] }
    data[:client] = Aws::Batch::Client
    @compute_environments = AWSBatchComputeEnvironments.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_compute_environments_exists
    assert @compute_environments.exist?
  end

  def test_compute_environment_names
    assert_equal(@compute_environments.compute_environment_names, ['test1'])
  end

  def test_compute_environment_arns
    assert_equal(@compute_environments.compute_environment_arns, ['test1'])
  end

  def test_ecs_cluster_arns
    assert_equal(@compute_environments.ecs_cluster_arns, ['test1'])
  end

  def test_types
    assert_equal(@compute_environments.types, ['test1'])
  end

  def test_states
    assert_equal(@compute_environments.states, ['test1'])
  end

  def test_statuses
    assert_equal(@compute_environments.statuses, ['test1'])
  end

  def test_status_reasons
    assert_equal(@compute_environments.status_reasons, ['test1'])
  end

  def test_service_roles
    assert_equal(@compute_environments.service_roles, ['test1'])
  end
end