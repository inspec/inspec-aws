require 'aws_backend'

class AwsSqsQueue < AwsResourceBase
  name 'aws_sqs_queue'
  desc 'Verifies settings for an SQS Queue.'
  example "
    describe aws_sqs_queue('queue-name') do
      it { should exist }
    end
  "

  attr_reader :arn, :is_fifo_queue, :visibility_timeout, :maximum_message_size, :message_retention_period, :delay_seconds,
              :receive_message_wait_timeout_seconds, :content_based_deduplication, :redrive_policy, :kms_master_key_id,
              :kms_data_key_reuse_period_seconds

  def initialize(opts = {})
    opts = { queue_url: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:queue_url])
    catch_aws_errors do
      resp = @aws.sqs_client.get_queue_attributes(queue_url: opts[:queue_url], attribute_names: ['All']).attributes
      @arn                                  = resp['QueueArn']
      @visibility_timeout                   = resp['VisibilityTimeout'].to_i
      @maximum_message_size                 = resp['MaximumMessageSize'].to_i
      @message_retention_period             = resp['MessageRetentionPeriod'].to_i
      @delay_seconds                        = resp['DelaySeconds'].to_i
      @receive_message_wait_timeout_seconds = resp['ReceiveMessageWaitTimeoutSeconds'].to_i
      @content_based_deduplication          = resp['ContentBasedDeduplication'].nil? ? false: true
      @is_fifo_queue                        = resp['FifoQueue'].nil? ? false: true
      @redrive_policy                       = resp['RedrivePolicy']
      @kms_master_key_id                    = resp['KmsMasterKeyId']
      @kms_data_key_reuse_period_seconds    = resp['KmsDataKeyReusePeriodSeconds']
    end
  end

  def resource_id
    @arn
  end

  def exists?
    !@arn.blank?
  end

  def to_s
    "AWS SQS Queue #{@arn}"
  end
end
