aws_user_pool_id = input(:aws_user_pool_id, value: '', description: '')
aws_client_id = input(:aws_client_id, value: '', description: '')
aws_client_name = input(:aws_client_name, value: '', description: '')

control 'aws-cognito-identity-pool-clients-1.0' do
  title 'Ensure AWS Cognito Identity Pool Clients has the correct properties.'

  describe aws_cognito_userpool_clients(user_pool_id: aws_user_pool_id) do
    it { should exist }
  end

  describe aws_cognito_userpool_clients(user_pool_id: aws_user_pool_id) do
    its('user_pool_ids') { should include aws_user_pool_id }
    its('client_ids') { should include aws_client_id }
    its('client_names') { should include aws_client_name }
  end
end
