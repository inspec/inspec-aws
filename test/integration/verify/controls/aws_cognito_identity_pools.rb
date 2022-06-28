aws_identity_pool_id = input(:aws_identity_pool_id, value: '', description: '')
aws_identity_pool_name = input(:aws_identity_pool_name, value: '', description: '')

control 'aws-cognito-identity-pools-1.0' do
  impact 1.0
  title 'Ensure AWS Identity Pools has the correct properties.'

  describe aws_cognito_identity_pools do
    it { should exist }
  end

  describe aws_cognito_identity_pools do
    its('identity_pool_ids') { should include aws_identity_pool_id }
    its('identity_pool_names') { should include aws_identity_pool_name }
  end
end