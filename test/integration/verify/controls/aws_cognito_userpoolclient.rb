aws_user_pool_id = attribute("aws_user_pool_id", default: "", description: "")
aws_client_id = attribute("aws_client_id", default: "", description: "")
aws_client_name = attribute("aws_client_name", default: "", description: "")

aws_client_secret = attribute("aws_client_secret", default: "", description: "")
aws_last_modified_date = attribute("aws_last_modified_date", default: "", description: "")
aws_creation_date = attribute("aws_creation_date", default: "", description: "")
aws_refresh_token_validity = attribute("aws_client_name", default: 30, description: "")
aws_access_token_validity = attribute("aws_client_name", default: 60, description: "")
aws_id_token_validity = attribute("aws_client_name", default: 60, description: "")
aws_token_validity_units_access_token = attribute("aws_token_validity_units_access_token", default: "minutes", description: "")
aws_token_validity_units_id_token = attribute("aws_token_validity_units_id_token", default: "minutes", description: "")
aws_token_validity_units_refresh_token = attribute("aws_token_validity_units_refresh_token", default: "days", description: "")

aws_read_attributes = attribute("aws_read_attributes", default: "address", description: "")
aws_write_attributes = attribute("aws_write_attributes", default: "address", description: "")
aws_explicit_auth_flows = attribute("aws_explicit_auth_flows", default: "", description: "")
aws_allowed_o_auth_flows_user_pool_client = attribute("aws_allowed_o_auth_flows_user_pool_client", default: false, description: "")
aws_prevent_user_existence_errors = attribute("aws_prevent_user_existence_errors", default: "", description: "")

control 'aws-auto-user-pool-client-1.0' do
  impact 1.0
  title 'Ensure AWS User Pool Client has the correct properties.'

  describe aws_cognito_userpool_client(user_pool_id: aws_user_pool_id, client_id: aws_client_id) do
    it { should exist }
  end
end

control 'aws-auto-user-pool-client-1.0' do
  impact 1.0
  title 'Ensure AWS User Pool Client has the correct properties.'

  describe aws_cognito_userpool_client(user_pool_id: aws_user_pool_id, client_id: aws_client_id) do
    its('user_pool_id') { should eq aws_user_pool_id }
    its('client_name') { should eq aws_client_name }
    its('client_id') { should eq aws_client_id }
    its('client_secret') { should eq aws_client_secret }
    its('last_modified_date') { should_not be_empty }
    its('creation_date') { should_not be_empty }
    its('token_validity_units.access_token') { should eq aws_token_validity_units_access_token }
    its('token_validity_units.id_token') { should eq aws_token_validity_units_id_token }
    its('token_validity_units.refresh_token') { should eq aws_token_validity_units_refresh_token }
  end
end

control 'aws-auto-user-pool-client-1.0' do
  impact 1.0
  title 'Ensure AWS User Pool Client has the correct properties.'

  describe aws_cognito_userpool_client(user_pool_id: aws_user_pool_id, client_id: aws_client_id) do
    its('read_attributes') { should include aws_read_attributes }
    its('write_attributes') { should include aws_write_attributes }
    its('explicit_auth_flows') { should include aws_explicit_auth_flows }
    its('supported_identity_providers') { should be_empty }
    its('callback_urls') { should be_empty }
    its('logout_urls') { should be_empty }
    its('default_redirect_uri') { should be_empty }
    its('allowed_o_auth_flows') { should be_empty }
    its('allowed_o_auth_scopes') { should be_empty }
    its('allowed_o_auth_flows_user_pool_client') { should eq aws_allowed_o_auth_flows_user_pool_client }
    its('analytics_configuration') { should be_empty }
    its('prevent_user_existence_errors') { should eq aws_prevent_user_existence_errors }
  end
end