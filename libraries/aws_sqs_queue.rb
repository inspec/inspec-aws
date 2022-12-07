require 'aws_backend'

class AwsSqsQueue < AwsResourceBase
  name 'aws_sqs_queue'
  desc 'Verifies settings for an SQS Queue.'
  example "
    describe aws_sqs_queue('test-queue-url') do
      it { should exist }
    end
  "

  attr_reader :arn, :is_fifo_queue, :visibility_timeout, :maximum_message_size, :message_retention_period, :delay_seconds,
              :receive_message_wait_timeout_seconds, :content_based_deduplication, :redrive_policy, :kms_master_key_id,
              :kms_data_key_reuse_period_seconds, :sqs_managed_enabled, :sqs_managed,
              :policy, :policy_statement, :policy_statement_sid, :policy_statement_effect, :policy_statement_principal, :policy_statement_action, :policy_statement_resource,
              :policy_statement_principal_all_permissions_enabled, :policy_statement_action_all_permissions_enabled

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
      @sqs_managed_enabled                  = resp['SqsManagedSseEnabled']
      @sqs_managed                          = resp['SqsManagedSseEnabled'].nil? ? false: true
      @policy                               = resp['Policy']
      create_resource_methods(resp.to_h)
    end
  end

  def resource_id
    @arn
  end

  def exists?
    !@arn.blank?
  end

  def to_s
    "SQS Queue URL: #{@arn}"
  end

  def policy_statement_principal_all_permissions_enabled?
    @policy_statement_principal_all_permissions_enabled = @policy_statement_principal.include? '*'
  end

  def policy_statement_action_all_permissions_enabled?
    @policy_statement_action_all_permissions_enabled = @policy_statement_action.include? '*'
  end
end
