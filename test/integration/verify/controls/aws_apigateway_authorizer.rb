aws_api_gateway_authorizer_id = input(:aws_api_gateway_authorizer_id, value: '', description: '')
aws_api_gateway_rest_api_id = input(:aws_api_gateway_rest_api_id, value: '', description: '')
aws_api_gateway_authorizer_authorizer_credentials = input(:aws_api_gateway_authorizer_authorizer_credentials, value: '', description: '')
aws_api_gateway_authorizer_authorizer_result_ttl_in_seconds = input(:aws_api_gateway_authorizer_authorizer_result_ttl_in_seconds, value: '', description: '')
aws_api_gateway_authorizer_authorizer_uri = input(:aws_api_gateway_authorizer_authorizer_uri, value: '', description: '')

control 'aws-apigateway-authorizer' do
  impact 1.0
  title 'Ensure API Gateway Authorizer resource has the correct properties.'

  describe aws_apigateway_authorizer(rest_api_id: aws_api_gateway_rest_api_id, authorizer_id: aws_api_gateway_authorizer_id) do
    it { should exist }
  end

  describe aws_apigateway_authorizer(rest_api_id: aws_api_gateway_rest_api_id, authorizer_id: aws_api_gateway_authorizer_id) do
    its('id') { should eq aws_api_gateway_authorizer_id }
    its('name') { should eq 'aws_api_gateway_authorizer_test_demo' }
    its('type') { should eq 'TOKEN' }
    its('provider_arns') { should be_empty }
    its('auth_type') { should eq 'custom' }
    its('authorizer_uri') { should eq aws_api_gateway_authorizer_authorizer_uri }
    its('authorizer_credentials') { should eq aws_api_gateway_authorizer_authorizer_credentials }
    its('identity_source') { should eq 'method.request.header.Authorization' }
    its('identity_validation_expression') { should be_empty }
    its('authorizer_result_ttl_in_seconds') { should eq aws_api_gateway_authorizer_authorizer_result_ttl_in_seconds }
  end
end