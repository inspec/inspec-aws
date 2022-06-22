aws_lambda_layer_arn = input(:aws_lambda_layer_arn, value: '', description: '')
aws_lambda_layer_version_layer_arn = input(:aws_lambda_layer_version_layer_arn, value: '', description: '')
aws_lambda_code_signing_config_description = input(:aws_lambda_code_signing_config_description, value: '', description: '')
aws_lambda_layer_version_created_date = input(:aws_lambda_layer_version_created_date, value: '', description: '')
aws_lambda_layer_version_source_code_size = input(:aws_lambda_layer_version_source_code_size, value: '', description: '')
aws_lambda_layer_version = input(:aws_lambda_layer_version, value: '', description: '')

control 'aws-lambda-version-1.0' do
  impact 1.0
  title 'Test the properties of the lambda version.'

  describe aws_lambda_version(layer_name: 'lambda_layer_name', version_number: 4) do
    it { should exist }
  end

  describe aws_lambda_version(layer_name: 'lambda_layer_name', version_number: 4) do
    its('content.location') { should_not be_empty }
    its('content.code_sha_256') { should_not be_empty }
    its('content.code_size') { should eq aws_lambda_layer_version_source_code_size }
    its('content.signing_profile_version_arn') { should be_empty }
    its('content.signing_job_arn') { should be_empty }
  end

  describe aws_lambda_version(layer_name: 'lambda_layer_name', version_number: 4) do
    its('layer_arn') { should eq aws_lambda_layer_arn }
    its('layer_version_arn') { should eq aws_lambda_layer_version_layer_arn }
    its('description') { should eq aws_lambda_code_signing_config_description }
    its('created_date') { should eq Time.parse(aws_lambda_layer_version_created_date) }
    its('version') { should eq aws_lambda_layer_version }
    its('compatible_runtimes') { should include 'nodejs12.x' }
    its('license_info') { should be_empty }
    its('compatible_architectures') { should be_empty }
  end
end
