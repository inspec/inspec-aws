describe aws_iam_instance_profile(instance_profile_name: 'a2-cluster-test_base_profile') do
    it { should exist }
end
  
describe aws_iam_instance_profile(instance_profile_name: 'a2-cluster-test_base_profile') do
    its('path') { should eq "/" }
    its('instance_profile_name') { should eq "a2-cluster-test_base_profile" }
    its('instance_profile_id') { should eq "AIPARUQHMSKVRYKXJJIXR" }
    its('arn') { should eq "arn:aws:iam::112758395563:instance-profile/a2-cluster-test_base_profile" }
    # its('create_date') { should_not be_empty }
    its('roles.first.path') { should eq "/" }
    its('roles.first.role_name') { should eq "a2-cluster-test_base_role" }
    its('roles.first.role_id') { should eq "AROARUQHMSKVZT2TNMOV6" }
    its('roles.first.arn') { should eq "arn:aws:iam::112758395563:role/a2-cluster-test_base_role" }
    # its('roles.first.create_date') { should_not be_empty }
    # its('roles.first.assume_role_policy_document') { should eq "%7B%22Version%22%3A%222012-10-17%22%2C%22Statement%22%3A%5B%7B%22Sid%22%3A%22%22%2C%22Effect%22%3A%2...s.amazonaws.com%22%2C%22ec2.amazonaws.com%22%5D%7D%2C%22Action%22%3A%22sts%3AAssumeRole%22%7D%5D%7D" }
    its('roles.first.description') { should be_empty }
    its('roles.first.max_session_duration') { should be_empty }
    its('roles.first.permissions_boundary') { should be_empty }
    its('roles.first.tags') { should be_empty }
    its('roles.first.role_last_used') { should be_empty }
    its('tags') { should be_empty }
end