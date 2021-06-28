control 'aws-lambda-function-permissions-1.0' do
  impact 1.0
  title 'List all the permissions of a lambda function.'

  describe aws_lambda_permissions(function_name: 'test1') do
    it { should exist }
  end

  describe aws_lambda_permissions(function_name: 'test1') do
    its('sids') { should include 'lambda-fb2d4da7-570a-4eb9-88fc-f6e553f6e28b' }
    its('effects') { should include 'Allow' }
    its('principals') { should_not be '' }
    its('resources') { should include 'arn:aws:lambda:us-east-2:112758395563:function:test1' }
  end
end
