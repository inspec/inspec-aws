aws_sns_subscription_arn = input(:aws_sns_subscription_arn, value: '', description: 'The AWS SNS subscription ARN.')
aws_account_id = input(:aws_account_id, value: '', description: 'The AWS account identifier.')
sns_sqs_queue_arn = input(:sns_sqs_queue_arn, value: '', description: 'The SNS SQS Queue ARN.')
aws_sns_topic_with_subscription_arn = input(:aws_sns_topic_with_subscription_arn, value: '', description: 'The AWS SNS topic ARN.')

control 'aws-sns-subscriptions-1.0' do
  impact 1.0
  title 'Ensure AWS SNS Subscriptions has the correct properties.'

  describe aws_sns_subscriptions do
    it { should exist }
  end

  describe aws_sns_subscriptions do
    its('subscription_arns') { should include aws_sns_subscription_arn }
    its('owners') { should include aws_account_id }
    its('protocols') { should include 'sqs' }
    its('endpoints') { should include sns_sqs_queue_arn }
    its('topic_arns') { should include aws_sns_topic_with_subscription_arn }
  end
end
