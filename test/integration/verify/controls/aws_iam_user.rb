title 'Test single AWS IAM User'

aws_iam_user_name = input(:aws_iam_user_name, value: '', description: 'The AWS IAM Username.')

control 'aws-iam-user-1.0' do
  impact 1.0
  title 'Ensure AWS IAM User has the correct properties.'

  describe aws_iam_user(aws_iam_user_name) do
    it { should exist }
    its ('username') { should eq aws_iam_user_name}
    its ('user_arn') { should_not be_nil}
  end

  describe aws_iam_user(user_name: aws_iam_user_name) do
    it { should exist }
    its("user_path") { should eq '/' }
    its("username") { should eq user_name }
    its("user_id") { should_not be_empty }
    its("user_arn") { should_not be_empty }
    its("user_create_date") { should_not be_empty }
    its("user_password_last_used") { should_not be_empty }
    its("user_permissions_boundary") { should_not be_empty }
    its("user_tags") { should be_empty }
  end
end
