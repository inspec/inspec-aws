aws_iam_instance_profile_name = input(:aws_iam_instance_profile_name1, value: '', description: '')
aws_iam_instance_profile_arn = input(:aws_iam_instance_profile_arn, value: '', description: '')

control 'aws-iam-instance-profiles-1.0' do
  impact 1.0
  title 'Ensure AWS IAM Instance Profiles has the correct properties.'

  describe aws_iam_instance_profiles do
    it { should exist }
  end
  
  describe aws_iam_instance_profiles do
    its('paths') { should include '/' }
    its('instance_profile_names') { should include aws_iam_instance_profile_name }
    its('arns') { should include aws_iam_instance_profile_arn }
    its('create_dates') { should_not be_empty }
    its('roles') { should_not be_empty }
  end
end
