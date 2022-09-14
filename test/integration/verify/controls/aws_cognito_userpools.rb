aws_user_pool_id = input(:aws_user_pool_id, value: '', description: '')
aws_identity_pool_name = input(:aws_identity_pool_name, value: '', description: '')

control 'aws-cognito-user-pools-1.0' do
  impact 1.0
  title 'Ensure AWS Cognito User Pool has the correct properties.'
  
  describe aws_cognito_userpools do
    it { should exist }
  end
  
  describe aws_cognito_userpools do
    its('ids') { should include aws_user_pool_id }
    its('names') { should include aws_identity_pool_name }
    its('lambda_configs') { should_not be_empty }
    its('statuses') { should_not be_empty }
  end
end