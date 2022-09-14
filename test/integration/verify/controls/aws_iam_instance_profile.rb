aws_iam_instance_profile_name = input(:aws_iam_instance_profile_name1, value: '', description: '')
aws_iam_instance_profile_arn = input(:aws_iam_instance_profile_arn, value: '', description: '')
aws_iam_instance_profile_id = input(:aws_iam_instance_profile_id, value: '', description: '')
aws_iam_role_name = input(:aws_iam_role_name1, value: '', description: '')
aws_iam_role_id = input(:aws_iam_role_id, value: '', description: '')
aws_iam_role_arn = input(:aws_iam_role_arn, value: '', description: '')

control 'aws-iam-instance-profile-1.0' do
  impact 1.0
  title 'Ensure AWS IAM Instance Profile has the correct properties.'

  describe aws_iam_instance_profile(instance_profile_name: aws_iam_instance_profile_name) do
    it { should exist }
  end

  describe aws_iam_instance_profile(instance_profile_name: aws_iam_instance_profile_name) do
    its('path') { should eq '/' }
    its('instance_profile_name') { should eq aws_iam_instance_profile_name }
    its('instance_profile_id') { should eq aws_iam_instance_profile_id }
    its('arn') { should eq aws_iam_instance_profile_arn }
    its('roles.first.path') { should eq '/' }
    its('roles.first.role_name') { should eq aws_iam_role_name }
    its('roles.first.role_id') { should eq aws_iam_role_id }
    its('roles.first.arn') { should eq aws_iam_role_arn }
    its('roles.first.description') { should be_empty }
    its('roles.first.max_session_duration') { should be_empty }
    its('roles.first.permissions_boundary') { should be_empty }
    its('roles.first.tags') { should be_empty }
    its('roles.first.role_last_used') { should be_empty }
    its('tags') { should be_empty }
  end

  describe aws_iam_instance_profile(instance_profile_name: 'dummy') do
    it { should exist }
  end
end
