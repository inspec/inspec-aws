aws_lambda_code_signing_config_id = attribute(:aws_lambda_code_signing_config_id, value: '')
aws_lambda_code_signing_config_arn = attribute(:aws_lambda_code_signing_config_arn, value: '')
aws_lambda_code_signing_config_description = attribute(:aws_lambda_code_signing_config_description, value: '')
aws_lambda_code_signing_config_last_modified = attribute(:aws_lambda_code_signing_config_last_modified, value: '')

control 'aws-lambda-alias-1.0' do
  impact 1.0
  title 'Test the properties of the lambda alias.'

  describe aws_lambda_code_signing_config(code_signing_config_arn: aws_lambda_code_signing_config_arn) do
    it { should exist }
  end

  describe aws_lambda_code_signing_config(code_signing_config_arn: aws_lambda_code_signing_config_arn) do
    its('code_signing_config_id') { should_not eq aws_lambda_code_signing_config_id }
    its('code_signing_config_arn') { should eq aws_lambda_code_signing_config_arn }
    its('description') { should eq aws_lambda_code_signing_config_description }
    its('allowed_publishers.signing_profile_version_arns') { should_not be_empty }
    its('code_signing_policies.untrusted_artifact_on_deployment') { should eq 'Warn' }
    its('last_modified') { should eq Time.parse(aws_lambda_code_signing_config_last_modified) }
  end
end