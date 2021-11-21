aws_user_pool_id = attribute("aws_user_pool_id", value: "", description: "")
aws_client_id = attribute("aws_client_id", value: "", description: "")
aws_client_name = attribute("aws_client_name", value: "", description: "")

control 'aws-auto-identity-pool-clients-1.0' do

  impact 1.0
  title 'Ensure AWS Identity Pool Clients has the correct properties.'

  describe aws_cognito_userpool_clients(user_pool_id: aws_user_pool_id) do
    it { should exist }
  end

  describe aws_cognito_userpool_clients(user_pool_id: aws_user_pool_id) do
    its('user_pool_ids') { should include aws_user_pool_id }
    its('client_ids') { should include aws_client_id }
    its('client_names') { should include aws_client_name }
  end
end