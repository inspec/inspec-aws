control 'aws-iam-root-password-1.0' do

  impact 1.0
  title 'Ensure AWS VPC has the correct properties.'

  describe aws_iam_root_user do
    it { should have_mfa_enabled }
    it { should have_virtual_mfa_enabled }
    it { should_not have_access_key }
  end
end
