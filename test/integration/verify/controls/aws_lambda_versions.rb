aws_lambda_layer_version_layer_arn = input(:aws_lambda_layer_version_layer_arn, value: '', description: '')
aws_lambda_layer_version_created_date = input(:aws_lambda_layer_version_created_date, value: '', description: '')
aws_lambda_layer_version = input(:aws_lambda_layer_version, value: '', description: '')

control 'aws-lambda-versions-1.0' do
  impact 1.0
  title 'Test the properties of the lambda versions.'

  describe aws_lambda_versions(layer_name: 'lambda_layer_name') do
    it { should exist }
  end

  describe aws_lambda_versions(layer_name: 'lambda_layer_name') do
    its('layer_version_arns') { should include aws_lambda_layer_version_layer_arn }
    its('versions') { should include aws_lambda_layer_version }
    its('descriptions') { should include nil }
    its('created_dates') { should include Time.parse(aws_lambda_layer_version_created_date) }
    its('compatible_runtimes') { should include ['nodejs12.x'] }
    its('license_infos') { should_not be_empty }
    its('compatible_architectures') { should_not be_empty }
  end
end
