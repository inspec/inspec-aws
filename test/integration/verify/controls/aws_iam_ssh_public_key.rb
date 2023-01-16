skip_control 'aws-iam-ssh-public-key-1.0' do
  title 'Test the properties of the iam ssh public key.'

  describe aws_iam_ssh_public_key(user_name: 'USER_NAME', ssh_public_key_id: 'SSH_PUBLIC_KEY_ID', encoding: 'SSH') do
    it { should exist }
  end

  describe aws_iam_ssh_public_key(user_name: 'USER_NAME', ssh_public_key_id: 'SSH_PUBLIC_KEY_ID', encoding: 'SSH') do
    its('user_name') { should eq 'USER_NAME' }
    its('ssh_public_key_id') { should eq 'SSH_PUBLIC_KEY_ID' }
    its('fingerprint') { should_not be_empty }
    its('ssh_public_key_body') { should_not be_empty }
    its('status') { should eq 'Active' }
    its('upload_date') { should_not be_empty }
  end

  describe aws_iam_ssh_public_key(user_name: 'USER_NAME', ssh_public_key_id: 'SSH_PUBLIC_KEY_ID', encoding: 'SSH') do
    its('ssh_key_age_valid') { should eq true }
  end
end
