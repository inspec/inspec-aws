title 'Test a collection AWS Groups'

aws_iam_group_name = attribute(:aws_iam_group_name, default: '', description: 'The AWS Iam Group name.')

control 'aws-iam-groups-1.0' do

  impact 1.0
  title 'Ensure AWS Iam Groups have the correct properties.'

  describe aws_iam_groups do
    it                   { should exist }
    its ('group_names')  { should include aws_iam_group_name }
  end
end