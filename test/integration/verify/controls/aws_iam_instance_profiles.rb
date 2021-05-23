describe aws_iam_instance_profiles do
    it { should exist }
  end
  
  describe aws_iam_instance_profiles do
    its('paths') { should include "/" }
    its('instance_profile_names') { should include "a2-cluster-test_base_profile" }
    its('arns') { should include "arn:aws:iam::112758395563:instance-profile/a2-cluster-test_base_profile" }
    its('create_dates') { should_not be_empty }
    its('roles') { should_not be_empty }
  end