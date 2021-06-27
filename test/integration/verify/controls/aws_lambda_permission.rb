control 'aws-lambda-function-permission-1.0' do
  impact 1.0
  title 'Describes the permission of the lambda function.'

  describe aws_lambda_permission(function_name: 'test1', Sid: 'lambda-fb2d4da7-570a-4eb9-88fc-f6e553f6e28b') do
    its('sid') { should eq 'lambda-fb2d4da7-570a-4eb9-88fc-f6e553f6e28b' }
    its('effect') { should eq 'Allow' }
    its('principal') { should_not be '' }
    its('resource') { should eq 'arn:aws:lambda:us-east-2:112758395563:function:test1' }
  end
end