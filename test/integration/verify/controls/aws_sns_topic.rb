title 'Test single AWS SNS Topic'

aws_region = attribute(:aws_region, default: '', description: 'The AWS region identifier.')
aws_account_id = attribute(:aws_account_id, default: '', description: 'The AWS account identifier.')
aws_sns_topic_with_subscription_arn = attribute(:aws_sns_topic_with_subscription_arn, default: '', description: 'The AWS SNS topic ARN.')
aws_sns_topic_no_subscription_arn = attribute(:aws_sns_topic_no_subscription_arn, default: '', description: 'The SNS topic ARN.')

control 'aws-sns-topic-1.0' do

  impact 1.0
  title 'Ensure AWS SNS Topic has the correct properties.'

  describe aws_sns_topic(arn: aws_sns_topic_with_subscription_arn) do
    it { should exist }
    its('confirmed_subscription_count') { should_not be_zero }
  end

  describe aws_sns_topic(arn: aws_sns_topic_no_subscription_arn) do
    it { should exist }
    its('confirmed_subscription_count') { should be_zero }
  end

  describe aws_sns_topic(arn: "arn:aws:sns:#{aws_region}:#{aws_account_id}:not-existing-arn-dxeeggchuqdbphgmmqebzzedu") do
    it { should_not exist }
  end
end