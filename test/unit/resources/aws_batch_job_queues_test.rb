require 'helper'
require 'aws_batch_job_queues'
require 'aws-sdk-core'

class AWSBatchJobQueuesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSBatchJobQueues.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSBatchJobQueues.new('rubbish') }
  end

  def test_job_queues_non_existing_for_empty_response
    refute AWSBatchJobQueues.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSBatchJobQueuesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_job_queues
    mock_parameter = {}
    mock_parameter[:job_queue_name] = 'test1'
    mock_parameter[:job_queue_arn] = 'test1'
    mock_parameter[:state] = 'test1'
    mock_parameter[:status] = 'test1'
    mock_parameter[:status_reason] = 'test1'
    mock_parameter[:priority] = 1
    mock_parameter[:compute_environment_order] = [{'order':1, 'compute_environment': 'test1'}]
    data[:data] = { job_queues: [mock_parameter] }
    data[:client] = Aws::Batch::Client
    @job_queues = AWSBatchJobQueues.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_job_definitions_exists
    assert @job_queues.exists?
  end

  def test_job_queue_names
    assert_equal(@job_queues.job_queue_names, ['test1'])
  end

  def test_job_queue_arns
    assert_equal(@job_queues.job_queue_arns, ['test1'])
  end

  def test_states
    assert_equal(@job_queues.states, ["test1"])
  end

  def test_statuses
    assert_equal(@job_queues.statuses, ['test1'])
  end

  def test_status_reasons
    assert_equal(@job_queues.status_reasons, ['test1'])
  end

  def test_priorities
    assert_equal(@job_queues.priorities, [1])
  end
end