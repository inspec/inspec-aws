title 'Test single AWS Iam Inline Policy'

# IAM User inline policy 
aws_iam_user_name = input(:aws_iam_user_name, value: '', description: 'The Attached AWS Iam Username.')
aws_iam_user_policy_name = input(:aws_iam_user_policy_name, value: '', description: 'The AWS Iam User Inline Policy.')

# IAM Role inline policy 
aws_iam_role_generic_name = input(:aws_iam_role_generic_name, value: '', description: 'The AWS Iam Role.')
aws_iam_role_generic_policy_name = input(:aws_iam_role_generic_policy_name, value: '', description: 'The AWS Iam Role Inline Policy.')

# IAM Group inline policy 
aws_iam_group_name = input(:aws_iam_group_name, value: '', description: 'The AWS Iam Group.')
aws_iam_group_policy_name = input(:aws_iam_group_policy_name, value: '', description: 'The AWS Iam Group Inline Policy.')

control 'aws-iam-inline-policy-1.0' do
  impact 1.0
  title 'Ensure AWS Iam Inline Policy has the correct properties.'

  # IAM User inline policy 
  describe aws_iam_inline_policy(user_name: aws_iam_user_name, policy_name: 'DoesNotExist') do
    it           { should_not exist }
  end  

  describe aws_iam_inline_policy(user_name: aws_iam_user_name, policy_name: aws_iam_user_policy_name) do
    it           { should exist }
    it { should_not have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => '*') }
    it { should have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => 'ec2:Describe*') }
    its('statement_count') { should > 0 }
  end

  # IAM Role inline policy 
  describe aws_iam_inline_policy(role_name: aws_iam_role_generic_name, policy_name: 'DoesNotExist') do
    it           { should_not exist }
  end  

  describe aws_iam_inline_policy(role_name: aws_iam_role_generic_name, policy_name: aws_iam_role_generic_policy_name) do
    it           { should exist }
    it { should_not have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => '*') }
    it { should have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => 'ec2:Describe*') }
    its('statement_count') { should > 0 }
  end

  # IAM Group inline policy 
  describe aws_iam_inline_policy(group_name: aws_iam_group_name, policy_name: 'DoesNotExist') do
    it           { should_not exist }
  end  

  describe aws_iam_inline_policy(group_name: aws_iam_group_name, policy_name: aws_iam_group_policy_name) do
    it           { should exist }
    it { should_not have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => '*') }
    it { should have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => 'ec2:Describe*') }
    its('statement_count') { should > 0 }
  end
end
