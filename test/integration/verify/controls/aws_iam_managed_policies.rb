skip_control 'aws-managed-policies-1.0' do
  title 'Ensure AWS IAM Managed Policy Plural resource has the correct properties.'

  describe aws_iam_managed_policies do
    it { should exist }
    its('policy_names') { should include 'ClientVPNServiceRolePolicy' }
    its('policy_ids') { should include 'ANPAI2SV25KUCYQYS5N74' }
    its('permissions_boundary_usage_count') { should include 0 }
  end

  describe aws_iam_managed_policies(scope: 'LOCAL') do
    it { should exist }
    its('policy_names') { should include 'ClientVPNServiceRolePolicy' }
    its('policy_ids') { should include 'ANPAI2SV25KUCYQYS5N74' }
    its('permissions_boundary_usage_count') { should include 0 }
  end
end

