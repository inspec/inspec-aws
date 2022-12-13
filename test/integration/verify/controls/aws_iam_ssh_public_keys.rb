skip_control 'aws-iam-ssh-public-keys-1.0' do
  title 'Test the properties of the iam ssh public keys.'

  describe aws_iam_ssh_public_keys(username: 'USER_NAME') do
    it { should exist }
  end

  describe aws_iam_ssh_public_keys(username: 'USER_NAME') do
    its('user_names') { should include 'USER_NAME' }
    its('ssh_public_key_ids') { should include 'SSH_PUBLIC_KEY_ID' }
    its('statuses') { should include 'Active' }
    its('upload_dates') { should_not be_empty }
  end

  describe aws_iam_ssh_public_keys do
    its('user_names') { should include 'USER_NAME' }
    its('ssh_public_key_ids') { should include 'SSH_PUBLIC_KEY_ID' }
    its('statuses') { should include 'Active' }
    its('upload_dates') { should_not be_empty }
  end
end
