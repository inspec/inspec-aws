title 'Test a collection of AWS Iam Policies'

aws_iam_policy_arn = input(:aws_iam_policy_arn, value: '', description: 'The AWS Iam Policy arn.')
aws_iam_attached_policy_arn = input(:aws_iam_attached_policy_arn, value: '', description: 'The AWS Iam Policy arn.')

control 'aws-iam-policies-1.0' do
  impact 1.0
  title 'Ensure AWS Iam Policies have the correct properties.'

  describe aws_iam_policies do
    it { should exist }
    its('arns') { should include aws_iam_policy_arn }
  end

  describe aws_iam_policies(scope: 'Local') do
    it { should exist }
    its('arns') { should include aws_iam_policy_arn }
  end

  describe aws_iam_policies(scope: 'AWS') do
    it { should exist }
    its('arns') { should_not include aws_iam_attached_policy_arn }
  end

  describe aws_iam_policies(only_attached: 'true') do
    it { should exist }
    its('arns') { should include aws_iam_attached_policy_arn }
  end
end
