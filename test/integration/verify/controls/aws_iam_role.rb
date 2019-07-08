aws_iam_role_name = attribute(:aws_iam_role_generic_name, default: '', description: 'The AWS IAM Role name.')
aws_iam_inline_policy_name = attribute(:aws_iam_role_generic_policy_name, default: '', description: 'The AWS IAM Role inline policy name.')
aws_iam_role_attached_policy_name = attribute(:aws_iam_attached_policy_name, default: '', description: 'The AWS IAM Role attached policy name.')
aws_iam_role_attached_policy_arn = attribute(:aws_iam_attached_policy_arn, default: '', description: 'The AWS IAM Role attached policy name.')

control 'AWS IAM Role search for default AWS role' do
  describe aws_iam_role(role_name: aws_iam_role_name) do
    it                            { should exist }
    its('role_name')              { should eq aws_iam_role_name }
    its('inline_policies')        { should include aws_iam_inline_policy_name }
    its('attached_policies_names') { should include aws_iam_role_attached_policy_name }
    its('attached_policies_arns')  { should include aws_iam_role_attached_policy_arn }
  end
end
