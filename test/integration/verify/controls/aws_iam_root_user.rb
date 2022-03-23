skip_control 'aws-iam-root-user-1.0' do
  impact 1.0
  title 'Test the AWS IAM Root User'

  describe aws_iam_root_user do
    it { should have_access_key }
    it { should have_account_signing_certificate }
    it { should have_MFA_devices_in_use }
    it { should have_policy_versions_in_use }
    it { should have_min_users }
    it { should have_virtual_mfa_enabled }
    it { should_not have_hardware_mfa_enabled }
    it { should have_mfa_enabled }
  end

  describe aws_iam_root_user do
    its('total_access_key_per_user_quota') { should eq 2 }
    its('total_access_keys_present') { should eq 0 }
    its('total_account_mfa_enabled') { should eq 1 }
    its('total_account_signing_certificates_present') { should eq 0 }
    its('total_attached_policies_per_group_quota') { should eq 10 }
    its('total_attached_policies_per_role_quota') { should eq 10 }
    its('total_attached_policies_per_user_quota') { should eq 10 }
    its('total_global_endpoint_token_version') { should eq 1 }
    its('total_group_policy_size_quota') { should eq 5120 }
    its('total_groups') { should eq 16 }
    its('total_groups_per_user_quota') { should eq 10 }
    its('total_groups_quota') { should eq 300 }
    its('total_mfa_devices') { should eq 2 }
    its('total_mfa_devices_in_use') { should eq 2 }
    its('total_policies') { should eq 124 }
    its('total_policies_quota') { should eq 1500 }
    its('total_policy_size_quota') { should eq 6144 }
    its('total_policy_versions_in_use') { should eq 221 }
    its('total_policy_versions_in_use_quota') { should eq 10000 }
    its('total_server_certificates') { should eq 1 }
    its('total_server_certificates_quota') { should eq 20 }
    its('total_signing_certificates_per_user_quota') { should eq 2 }
    its('total_user_policy_size_quota') { should eq 2048 }
    its('total_users') { should eq 94 }
    its('total_users_quota') { should eq 5000 }
    its('total_versions_per_policy_quota') { should eq 5 }
  end
end
