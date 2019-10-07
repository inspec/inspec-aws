title 'Test single AWS IAM User'

aws_iam_user_name = attribute(:aws_iam_user_name, default: '', description: 'The AWS IAM Username.')

control 'aws-iam-user-1.0' do

  impact 1.0
  title 'Ensure AWS IAM User has the correct properties.'

  describe aws_iam_user(aws_iam_user_name) do
    it               { should exist }
    its ('username') { should eq aws_iam_user_name}
    its ('user_arn') { should_not be_nil}
  end
end