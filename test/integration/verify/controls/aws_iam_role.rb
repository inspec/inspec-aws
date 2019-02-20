aws_iam_role_name = attribute(:aws_iam_role_generic_name, default: '', description: 'The AWS IAM Role name.')

control 'AWS IAM Role search for default AWS role' do
  describe aws_iam_role(role_name: aws_iam_role_name) do
    it               { should exist }
    its('role_name') { should eq aws_iam_role_name }
  end
end
