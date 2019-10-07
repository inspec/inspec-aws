title 'Test a collection of AWS IAM Users'

aws_iam_user_name = attribute(:aws_iam_user_name, default: '', description: 'The User Name')

control 'aws-iam-users-1.0' do

  impact 1.0
  title 'Ensure AWS IAM Users plural resource has the correct properties.'

  describe aws_iam_users do
    it                { should exist }
    its ('usernames') { should include aws_iam_user_name }
  end
end