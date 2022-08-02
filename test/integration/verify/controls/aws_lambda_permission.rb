aws_lambda_function_arn = input(:lambda_function_arn, value: '', description: '')

control 'aws-lambda-function-permission-1.0' do
  impact 1.0
  title 'Describes the permission of the lambda function.'

  describe aws_lambda_permission(function_name: 'test_Lambda', Sid: 'AllowExecutionFromSqs') do
    its('sid') { should eq 'AllowExecutionFromSqs' }
    its('effect') { should eq 'Allow' }
    its('principal') { should_not be '' }
    its('resource') { should eq aws_lambda_function_arn }
  end
end
