require_relative '../aws_base_resource_mock'

class AwsSqsQueueMock < AwsBaseResourceMock

  def initialize
    super
    @queue = {}
    @attributes = {"QueueArn"=> @aws.any_arn,
                   "VisibilityTimeout"=> @aws.any_int.to_s,
                   "MaximumMessageSize"=> @aws.any_int.to_s,
                   "MessageRetentionPeriod"=> @aws.any_int.to_s,
                   "DelaySeconds"=> @aws.any_int.to_s,
                   "ReceiveMessageWaitTimeoutSeconds"=> @aws.any_int.to_s,
                   "RedrivePolicy"=> "{\"deadLetterTargetArn\":\"arn:aws:sqs:us-east-1:123:my_arn\",\"maxReceiveCount\":4}",
                   "KmsMasterKeyId"=> "alias/aws/sqs",
                   "KmsDataKeyReusePeriodSeconds"=> @aws.any_int.to_s}
    @queue[:attributes] = @attributes
  end

  def stub_data
    stub_data = []

    queue = {:client => Aws::SQS::Client,
             :method => :get_queue_attributes,
             :data => @queue}

    stub_data += [queue]
  end

  def queue
    @queue
  end
end