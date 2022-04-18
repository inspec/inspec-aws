title 'Test single AWS SNS Topic'

aws_region = attribute(:aws_region, value: '', description: 'The AWS region identifier.')
aws_account_id = attribute(:aws_account_id, value: '', description: 'The AWS account identifier.')
aws_sns_topic_with_subscription_arn = attribute(:aws_sns_topic_with_subscription_arn, value: '', description: 'The AWS SNS topic ARN.')
aws_sns_topic_no_subscription_arn = attribute(:aws_sns_topic_no_subscription_arn, value: '', description: 'The SNS topic ARN.')
aws_sns_topic_with_encryption_arn = attribute(:aws_sns_topic_with_encryption_arn, value: '', description: 'The AWS SNS topic with encryption ARN.')
kms_master_key_id = attribute(:aws_sns_topic_kms_master_key_id, value: '', description: 'The AWS SNS topic kms master key id.')

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

  describe aws_sns_topic(arn: aws_sns_topic_with_encryption_arn) do
    its('kms_master_key_id') { should eq kms_master_key_id }
  end

  describe aws_sns_topic(arn: "arn:aws:sns:#{aws_region}:#{aws_account_id}:not-existing-arn-dxeeggchuqdbphgmmqebzzedu") do
    it { should_not exist }
  end

  describe aws_sns_topic(aws_sns_topic_with_encryption_arn) do
    it { should exist }
    its('policy_statement_action') { should include "SNS:Subscribe" }
    its('policy_statement_action') { should eq ["SNS:GetTopicAttributes", "SNS:SetTopicAttributes", "SNS:AddPermission", "SNS:RemovePermission", "SNS:DeleteTopic", "SNS:Subscribe", "SNS:ListSubscriptionsByTopic", "SNS:Publish", "SNS:Receive"] }
  end
end
