title 'Test single AWS Iam Policy'

aws_iam_policy_arn = attribute(:aws_iam_policy_arn, default: '', description: 'The AWS Iam Policy arn.')
aws_iam_policy_name = attribute(:aws_iam_policy_name, default: '', description: 'The AWS Iam Policy name.')

control 'aws-iam-policy-1.0' do

  impact 1.0
  title 'Ensure AWS Iam Policy has the correct properties.'

  describe aws_iam_policy(policy_arn: aws_iam_policy_arn) do
    it           { should exist }
    its ('arn')  { should eq aws_iam_policy_arn }
  end

  # policy_name param used to maintain consistency with old implementation
  describe aws_iam_policy(policy_name: aws_iam_policy_name) do
    it           { should exist }
    its ('arn')  { should eq aws_iam_policy_arn }
  end
end