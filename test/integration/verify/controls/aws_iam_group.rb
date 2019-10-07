title 'Test single AWS Group'

aws_iam_group_name = attribute(:aws_iam_group_name, default: '', description: 'The AWS Iam Group name.')

control 'aws-iam-group-1.0' do

  impact 1.0
  title 'Ensure AWS Iam Group has the correct properties.'

  describe aws_iam_group(group_name: aws_iam_group_name) do
    it                  { should exist }
    its ('group_name')  { should eq aws_iam_group_name }
  end
end