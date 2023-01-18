title 'Test an IAM Password Policy'

control 'aws-iam-password-policy-1.0' do
  title 'Ensure AWS IAM Password Policy has the correct properties.'

  describe aws_iam_password_policy do
    it { should exist }
    it { should prevent_password_reuse }
    it { should require_numbers }
    it { should require_symbols }
    it { should require_lowercase_characters }
    it { should require_uppercase_characters}
    it { should allow_users_to_change_password }
    its('minimum_password_length')         { should be > 6 }
    its('number_of_passwords_to_remember') { should be > 3 }
  end
end
