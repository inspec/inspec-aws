skip_control 'aws-managed-policy-1.0' do
  title 'Ensure AWS IAM Managed Policy Singular resource has the correct properties.'

  describe aws_iam_managed_policy(policy_arn: 'arn:aws:iam::aws:policy/aws-service-role/ClientVPNServiceRolePolicy') do
    it { should exist }
    its('description') { should eq 'Policy to enable AWS Client VPN to manage your Client VPN endpoints.' }
    its('policy_name') { should eq 'ClientVPNServiceRolePolicy' }
    its('policy_id') { should eq 'ANPAI2SV25KUCYQYS5N74' }
    its('permissions_boundary_usage_count') { should eq 0 }
  end
end

