title 'Test single AWS KMS Key'

aws_kms_key_enabled_id = input(:aws_kms_key_enabled_id, value: '', description: 'The AWS KMS key ID.')
aws_kms_key_enabled_arn = input(:aws_kms_key_enabled_arn, value: '', description: 'The AWS KMS key ARN.')
aws_kms_key_disabled_id = input(:aws_kms_key_disabled_id, value: '', description: 'The AWS KMS key ID.')
aws_kms_key_disabled_arn = input(:aws_kms_key_disabled_arn, value: '', description: 'The AWS KMS key ARN.')
aws_key_description_enabled = input(:aws_key_description_enabled, value: '', description: 'The AWS KMS key description.')
aws_key_description_disabled = input(:aws_key_description_disabled, value: '', description: 'The AWS KMS key description.')

control 'aws-kms-key-1.0' do
  title 'Ensure AWS KMS Key has the correct properties.'

  describe aws_kms_key(aws_kms_key_enabled_id) do
    it { should exist }
    its('key_id') { should eq aws_kms_key_enabled_id }
    its('arn') { should eq aws_kms_key_enabled_arn }
    its('description') { should eq aws_key_description_enabled }
    its('created_days_ago') { should be >= 0 }
    its('key_usage') { should eq 'ENCRYPT_DECRYPT' }
    its('key_state') { should eq 'Enabled' }
    it { should be_enabled }
    it { should_not be_external }
    it { should_not be_managed_by_aws }
    it { should_not have_key_expiration }
    it { should have_rotation_enabled }
  end

  describe aws_kms_key(key_id: aws_kms_key_enabled_arn) do
    it { should exist }
    its('key_id') { should eq aws_kms_key_enabled_id }
    its('arn') { should eq aws_kms_key_enabled_arn }
    its('description') { should eq aws_key_description_enabled }
    its('created_days_ago') { should be >= 0 }
    its('key_usage') { should eq 'ENCRYPT_DECRYPT' }
    its('key_state') { should eq 'Enabled' }
    it { should be_enabled }
    it { should_not be_external }
    it { should_not be_managed_by_aws }
    it { should_not have_key_expiration }
    it { should have_rotation_enabled }
  end

  describe aws_kms_key(key_id: aws_kms_key_enabled_id) do
    it { should exist }
    its('key_id') { should eq aws_kms_key_enabled_id }
    its('arn') { should eq aws_kms_key_enabled_arn }
    its('description') { should eq aws_key_description_enabled }
    its('created_days_ago') { should be >= 0 }
    its('key_usage') { should eq 'ENCRYPT_DECRYPT' }
    its('key_state') { should eq 'Enabled' }
    it { should be_enabled }
    it { should_not be_external }
    it { should_not be_managed_by_aws }
    it { should_not have_key_expiration }
    it { should have_rotation_enabled }
  end

  describe aws_kms_key(key_id: aws_kms_key_disabled_id) do
    it { should exist }
    its('key_id') { should eq aws_kms_key_disabled_id }
    its('arn') { should eq aws_kms_key_disabled_arn }
    its('description') { should eq aws_key_description_disabled }
    its('created_days_ago') { should be >= 0 }
    its('key_usage') { should eq 'ENCRYPT_DECRYPT' }
    it { should_not be_external }
    it { should_not be_managed_by_aws }
    it { should_not have_key_expiration }
    it { should_not have_rotation_enabled }
  end

  describe aws_kms_key(alias: "alias/#{aws_kms_key_disabled_id}") do
    it { should exist }
    its('key_id') { should eq aws_kms_key_disabled_id }
    its('arn') { should eq aws_kms_key_disabled_arn }
    its('description') { should eq aws_key_description_disabled }
    its('created_days_ago') { should be >= 0 }
    its('key_usage') { should eq 'ENCRYPT_DECRYPT' }
    it { should_not be_external }
    it { should_not be_managed_by_aws }
    it { should_not have_key_expiration }
    it { should_not have_rotation_enabled }
  end

  describe aws_kms_key(key_id: '8f9df97b-cb3d-4b3a-8fcb-aa892a9345e3') do
    it { should_not exist }
  end
end
