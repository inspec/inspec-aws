control 'aws-iam-ssh-public-key-1.0' do
  impact 1.0
  title 'Test the properties of the iam ssh public key.'

  describe aws_iam_ssh_public_key(user_name: 'skarmaka@progress.com', ssh_public_key_id: 'APKARUQHMSKV3ZHSN55G', encoding: 'SSH') do
    it { should exist }
  end

  describe aws_iam_ssh_public_key(user_name: 'skarmaka@progress.com', ssh_public_key_id: 'APKARUQHMSKV3ZHSN55G', encoding: 'SSH') do
    its('user_name') { should eq 'skarmaka@progress.com' }
    its('ssh_public_key_id') { should eq 'APKARUQHMSKV3ZHSN55G' }
    its('fingerprint') { should_not be_empty }
    its('ssh_public_key_body') { should_not be_empty }
    its('status') { should eq 'Active' }
    its('upload_date') { should eq Time.parse('2021-10-06 14:52:50.000000000 +0000') }
  end

  describe aws_iam_ssh_public_key(user_name: 'skarmaka@progress.com', ssh_public_key_id: 'APKARUQHMSKV3ZHSN55G', encoding: 'SSH') do
    its('ssh_key_age_valid') { should eq true }
  end
end