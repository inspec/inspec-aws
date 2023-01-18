aws_lambda_code_signing_config_id = input(:aws_lambda_code_signing_config_id, value: '', description: '')
aws_lambda_code_signing_config_arn = input(:aws_lambda_code_signing_config_arn, value: '', description: '')
aws_lambda_code_signing_config_description = input(:aws_lambda_code_signing_config_description, value: '', description: '')
aws_lambda_code_signing_config_last_modified = input(:aws_lambda_code_signing_config_last_modified, value: '', description: '')

control 'aws-lambda-code-signing-configs-1.0' do
  title 'Test the properties of the lambda code signing configs.'

  describe aws_lambda_code_signing_configs do
    it { should exist }
  end

  describe aws_lambda_code_signing_configs do
    its('code_signing_config_ids') { should_not include aws_lambda_code_signing_config_id }
    its('code_signing_config_arns') { should include aws_lambda_code_signing_config_arn }
    its('descriptions') { should include aws_lambda_code_signing_config_description }
    its('allowed_publishers') { should_not be_empty }
    its('code_signing_policies') { should_not be_empty }
    its('last_modified') { should include Time.parse(aws_lambda_code_signing_config_last_modified) }
  end
end
