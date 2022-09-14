title 'Test AWS KMS Keys in bulk'

aws_kms_key_enabled_id = input(:aws_kms_key_enabled_id, value: '', description: 'The AWS KMS key ID.')
aws_kms_key_enabled_arn = input(:aws_kms_key_enabled_arn, value: '', description: 'The AWS KMS key ARN.')
aws_kms_key_disabled_id = input(:aws_kms_key_disabled_id, value: '', description: 'The AWS KMS key ID.')
aws_kms_key_disabled_arn = input(:aws_kms_key_disabled_arn, value: '', description: 'The AWS KMS key ARN.')

control 'aws-kms-keys-1.0' do
  impact 1.0
  title 'Ensure AWS VPC plural resource has the correct properties.'

  describe aws_kms_keys do
    it { should exist }
    its('count') { should be <= 10000 }
    its('key_ids') { should include aws_kms_key_enabled_id }
    its('key_ids') { should include aws_kms_key_disabled_id }
    its('key_arns') { should include aws_kms_key_enabled_arn }
    its('key_arns') { should include aws_kms_key_disabled_arn }
  end
end
