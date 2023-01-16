aws_identity_pool_id = input(:aws_identity_pool_id, value: '', description: '')
aws_identity_pool_name = input(:aws_identity_pool_name, value: '', description: '')
aws_allow_unauthenticated_identities = input(:aws_allow_unauthenticated_identities, value: false, description: '')

control 'aws-cognito-identity-pool-1.0' do
  title 'Ensure AWS Identity Pool has the correct properties.'

  describe aws_cognito_identity_pool(identity_pool_id: aws_identity_pool_id) do
    it { should exist }
  end

  describe aws_cognito_identity_pool(identity_pool_id: aws_identity_pool_id) do
    its('identity_pool_id') { should eq aws_identity_pool_id }
    its('identity_pool_name') { should eq aws_identity_pool_name }
    its('allow_unauthenticated_identities') { should eq aws_allow_unauthenticated_identities }
    its('developer_provider_name') { should be_empty }
    its('cognito_identity_providers') { should_not be_empty }
    its('saml_provider_arns') { should be_empty }
    its('identity_pool_tags') { should be_empty }
  end

  describe aws_cognito_identity_pool(identity_pool_id: 'dummy') do
    it { should_not exist }
  end
end
