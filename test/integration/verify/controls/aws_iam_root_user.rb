control 'aws-iam-root-user-1.0' do
  title 'Test the AWS IAM Root User'

  describe aws_iam_root_user do
    # Leaving below as examples:
    # it { should have_mfa_enabled }
    # it { should have_virtual_mfa_enabled }
    it { should_not have_access_key }
  end
end
