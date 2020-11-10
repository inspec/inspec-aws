require 'aws-sdk-core'
require 'aws_sqs_queue'
require 'helper'
require_relative 'mock/iam/aws_sqs_queue_mock'

class AwsSqsQueueConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsSqsQueue.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_queue_url
    AwsSqsQueue.new(queue_url: 'https://sqs.mock.com/mock-queue', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsSqsQueue.new(rubbish: 9) }
  end

  def test_queue_not_existing
    refute AwsSqsQueue.new(queue_url: 'https://sqs.mock.com/mock-queue', client_args: { stub_responses: true }).exists?
  end
end

class AwsSqsQueueTest < Minitest::Test

  def setup
    # Given
    @mock = AwsSqsQueueMock.new
    @mock_queue = @mock.queue

    # When
    @queue = AwsSqsQueue.new(queue_url: "https://sqs.mock.com/mock-queue",
                            client_args: { stub_responses: true },
                            stub_data: @mock.stub_data)
  end

  def test_exists
    assert @queue.exists?
  end

  def test_sqs_queue_arn
    assert_equal(@queue.arn, @mock_queue[:attributes]['QueueArn'])
  end

  def test_sqs_queue_visibility_timeout
    assert_equal(@queue.visibility_timeout, @mock_queue[:attributes]['VisibilityTimeout'].to_i)
  end

  def test_sqs_queue_maximum_message_size
    assert_equal(@queue.maximum_message_size, @mock_queue[:attributes]['MaximumMessageSize'].to_i)
  end

  def test_sqs_queue_message_retention_period
    assert_equal(@queue.message_retention_period, @mock_queue[:attributes]['MessageRetentionPeriod'].to_i)
  end

  def test_sqs_queue_delay_seconds
    assert_equal(@queue.delay_seconds, @mock_queue[:attributes]['DelaySeconds'].to_i)
  end

  def test_sqs_queue_receive_message_wait_timeout_seconds
    assert_equal(@queue.receive_message_wait_timeout_seconds, @mock_queue[:attributes]['ReceiveMessageWaitTimeoutSeconds'].to_i)
  end

  def test_sqs_queue_content_based_deduplication
    assert_equal(@queue.content_based_deduplication, false)
  end

  def test_sqs_queue_is_fifo_queue
    assert_equal(@queue.is_fifo_queue, false)
  end

  def test_sqs_queue_redrive_policy
    assert_equal(@queue.redrive_policy, @mock_queue[:attributes]['RedrivePolicy'])
  end

  def test_sqs_queue_kms_id
    assert_equal(@queue.kms_master_key_id, @mock_queue[:attributes]['KmsMasterKeyId'])
  end

  def test_sqs_queue_kms_key_reuse_period
    assert_equal(@queue.kms_data_key_reuse_period_seconds, @mock_queue[:attributes]['KmsDataKeyReusePeriodSeconds'])
  end

end