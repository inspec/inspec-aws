title 'Test AWS SNS Topics in bulk'

aws_region = attribute(:aws_region, default: '', description: 'The AWS region identifier.')
aws_account_id = attribute(:aws_account_id, default: '', description: 'The AWS account identifier.')
aws_sns_topic_with_subscription_arn = attribute(:aws_sns_topic_with_subscription_arn, default: '', description: 'The AWS SNS topic ARN.')
aws_sns_topic_no_subscription_arn = attribute(:aws_sns_topic_no_subscription_arn, default: '', description: 'The SNS topic ARN.')

control 'aws-sns-topics-1.0' do

  impact 1.0
  title 'Ensure AWS SNS Topic plural resource has the correct properties.'

  describe aws_sns_topics do
    it { should exist }
    its('count') { should be >= 2 }
    its('topic_arns') { should include aws_sns_topic_with_subscription_arn }
    its('topic_arns') { should include aws_sns_topic_no_subscription_arn }
    its('topic_arns') { should_not include "arn:aws:sns:#{aws_region}:#{aws_account_id}:not-existing-arn-dxeeggchuqdbphgmmqebzzedu" }
  end
end