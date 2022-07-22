control 'aws-iam-account-alias-1.0' do
  impact 1.0
  title 'Test the AWS IAM Account Alias'

  describe aws_iam_account_alias do
    it { should exist }
    its('alias') { should_not be_nil}
  end
end
