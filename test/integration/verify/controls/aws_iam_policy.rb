title 'Test single AWS Iam Policy'

aws_iam_policy_arn = input(:aws_iam_policy_arn, value: '', description: 'The AWS Iam Policy arn.')
aws_iam_policy_name = input(:aws_iam_policy_name, value: '', description: 'The AWS Iam Policy name.')
aws_iam_attached_policy_name = input(:aws_iam_attached_policy_name, value: '', description: 'The AWS Iam Attached Policy name.')
aws_iam_user_name = input(:aws_iam_user_name, value: '', description: 'The Attached AWS Iam Username.')
aws_iam_role_generic_name = input(:aws_iam_role_generic_name, value: '', description: 'The AWS Iam Role.')

control 'aws-iam-policy-1.0' do
  impact 1.0
  title 'Ensure AWS Iam Policy has the correct properties.'

  describe aws_iam_policy(policy_arn: aws_iam_policy_arn) do
    it           { should exist }
    its ('arn')  { should eq aws_iam_policy_arn }
  end

  describe aws_iam_policy(policy_name: 'DoesNotExist') do
    it           { should_not exist }
  end

  # policy_name param used to maintain consistency with old implementation
  describe aws_iam_policy(policy_name: aws_iam_policy_name) do
    it           { should exist }
    its ('arn')  { should eq aws_iam_policy_arn }
    it { should_not have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => '*') }
    it { should have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => 'ec2:Describe*') }
    it { should have_statement('Effect' => 'Allow', 'Resource' => 'arn:aws:s3:::*', 'NotAction' => 's3:DeleteBucket') }
    its('statement_count') { should > 1 }
  end

  describe aws_iam_policy(policy_name: aws_iam_attached_policy_name) do
    it { should be_attached_to_user(aws_iam_user_name) }
    it { should be_attached_to_role(aws_iam_role_generic_name) }
    it { should_not be_attached_to_user("fake-user") }
    it { should_not be_attached_to_role("fake-role") }
    # Test Action in an array
    it { should have_statement(Action: ["ec2:Describe*"]) }
  end
end
