require 'helper'
require 'aws_batch_job_queue'
require 'aws-sdk-core'

class AWSBatchJobQueueConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSBatchJobQueue.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSBatchJobQueue.new(job_queue_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSBatchJobQueue.new(unexpected: 9) }
  end
end

class AWSBatchJobQueueSuccessPathTest < Minitest::Test

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
    @job_queues = AWSBatchJobQueue.new(job_queue_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_job_queue_exists
    assert @job_queues.exists?
  end

  def test_job_queue_arn
    assert_equal(@job_queues.job_queue_arn, 'test1')
  end

  def test_state
    assert_equal(@job_queues.state, 'test1')
  end

  def test_status
    assert_equal(@job_queues.status, 'test1')
  end

  def test_status_reason
    assert_equal(@job_queues.status_reason, 'test1')
  end

  def test_priority
    assert_equal(@job_queues.priority, 1)
  end

  def test_resource_id
    refute_nil(@job_queues.resource_id)
    assert_equal(@job_queues.resource_id, 'test1')
  end
end