aws_secretsmanager_secret_sm_arn = input(:aws_secretsmanager_secret_sm_arn, value: '', description: '')

control 'aws-secretsmanager-secrets-1.0' do
  impact 1.0
  title 'Lists all of the secrets that are stored by Secrets Manager in the AWS account.'

  describe aws_secretsmanager_secrets do
    it { should exist }
  end

  describe aws_secretsmanager_secrets do
    its("arns") { should include aws_secretsmanager_secret_sm_arn }
    its("names") { should include "secret-manager-test" }
    its("descriptions") { should include "Test Description." }
    its("kms_key_ids") { should_not be_empty }
    its("rotation_enableds") { should_not be_empty }
    its("rotation_lambda_arns") { should_not be_empty }
    its("rotation_rules") { should_not be_empty }
    its("last_rotated_dates") { should_not be_empty }
    its("last_changed_dates") { should_not be_empty }
    its("last_accessed_dates") { should_not be_empty }
    its("deleted_dates") { should_not be_empty }
    its("tags") { should_not be_empty }
    its("owning_services") { should_not be_empty }
    its("created_dates") { should_not be_empty }
  end
end
