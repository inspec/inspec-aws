aws_secretsmanager_secret_sm_id = input(:aws_secretsmanager_secret_sm_id, value: '', description: '')
aws_secretsmanager_secret_sm_arn = input(:aws_secretsmanager_secret_sm_arn, value: '', description: '')

control 'aws-secretsmanager-secret-1.0' do
  title 'Lists all of the secrets that are stored by Secrets Manager in the AWS account.'

  describe aws_secretsmanager_secret(secret_id: aws_secretsmanager_secret_sm_id) do
    it { should exist }
  end

  describe aws_secretsmanager_secret(secret_id: aws_secretsmanager_secret_sm_id) do
    its("arn") { should eq aws_secretsmanager_secret_sm_arn }
    its("name") { should eq "secret-manager-test" }
    its("description") { should eq "Test Description." }
    its("kms_key_id") { should be_empty }
    its("rotation_enabled") { should be_empty }
    its("rotation_lambda_arn") { should be_empty }
    its("rotation_rules.automatically_after_days") { should be_empty }
    its("last_rotated_date") { should be_empty }
    its("last_accessed_date") { should be_empty }
    its("deleted_date") { should be_empty }
    its("tags") { should_not be_empty }
    its("owning_service") { should be_empty }
  end
end
