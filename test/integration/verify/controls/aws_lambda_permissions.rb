aws_lambda_function_arn = input(:lambda_function_arn, value: '', description: '')

control 'aws-lambda-function-permissions-1.0' do
  impact 1.0
  title 'List all the permissions of a lambda function.'

  describe aws_lambda_permissions(function_name: 'test_Lambda') do
    it { should exist }
  end

  describe aws_lambda_permissions(function_name: 'test_Lambda') do
    its('sids') { should include 'AllowExecutionFromSqs' }
    its('effects') { should include 'Allow' }
    its('principals') { should_not be '' }
    its('resources') { should include aws_lambda_function_arn }
  end
end
