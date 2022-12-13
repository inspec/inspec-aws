skip_control 'aws-api-gateway-method-1.0' do
  title 'Test the properties of the api gateway method.'
  
  describe aws_api_gateway_methods(rest_api_id: '', resource_id: '', http_method: 'GET') do
    it { should exist }
  end

  describe aws_api_gateway_methods(rest_api_id: '', resource_id: '', http_method: 'GET') do
    its('http_methods') { should include 'GET' }
    its('authorization_types') { should include 'NONE' }
    its('authorizer_ids') { should_not be_empty }
    its('api_key_required') { should include false }
    its('request_validator_ids') { should_not be_empty }
    its('operation_names') { should_not be_empty }
    its('request_parameters') { should_not be_empty }
    its('request_models') { should_not be_empty }
    its('method_responses') { should_not be_empty }
    its('method_integrations') { should_not be_empty }
    its('authorization_scopes') { should_not be_empty }
  end

  describe aws_api_gateway_methods(rest_api_id: 'dummy', resource_id: 'dummy', http_method: 'GET') do
    it { should_not exist }
  end
end
