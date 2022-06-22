title 'Test single AWS SNS Subscription'

aws_account_id = input(:aws_account_id, value: '', description: 'The AWS account identifier.')
aws_sns_subscription_arn = input(:aws_sns_subscription_arn, value: '', description: 'The AWS SNS subscription ARN.')
aws_sns_topic_with_subscription_arn = input(:aws_sns_topic_with_subscription_arn, value: '', description: 'The AWS SNS topic ARN.')
sns_sqs_queue_arn = input(:sns_sqs_queue_arn, value: '', description: 'The SNS SQS Queue ARN.')

control 'aws-sns-subscription-1.0' do
  impact 1.0
  title 'Ensure AWS SNS Subscription has the correct properties.'

  describe aws_sns_subscription(subscription_arn: aws_sns_subscription_arn) do
    it { should exist }
    its('topic_arn') { should eq aws_sns_topic_with_subscription_arn }
    its('endpoint') { should eq sns_sqs_queue_arn }
    its('protocol') { should eq 'sqs' }
    its('owner') { should cmp aws_account_id }
    it { should_not have_raw_message_delivery }
    it { should be_confirmation_authenticated }
  end

  describe aws_sns_subscription(aws_sns_subscription_arn) do
    it { should exist }
    its('topic_arn') { should eq aws_sns_topic_with_subscription_arn }
    its('endpoint') { should eq sns_sqs_queue_arn }
    its('protocol') { should eq 'sqs' }
    its('owner') { should cmp aws_account_id }
    it { should_not have_raw_message_delivery }
    it { should be_confirmation_authenticated }
  end

  describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1:721741954427:NonExistentSubscrtiption:bf007420-6-45-96-9c2bf144') do
    it { should_not exist }
  end
end
