aws_api_gateway_authorizer_id = input(:aws_api_gateway_authorizer_id, value: '', description: '')
aws_api_gateway_rest_api_id = input(:aws_api_gateway_rest_api_id, value: '', description: '')
aws_api_gateway_authorizer_authorizer_credentials = input(:aws_api_gateway_authorizer_authorizer_credentials, value: '', description: '')
aws_api_gateway_authorizer_authorizer_result_ttl_in_seconds = input(:aws_api_gateway_authorizer_authorizer_result_ttl_in_seconds, value: '', description: '')
aws_api_gateway_authorizer_authorizer_uri = input(:aws_api_gateway_authorizer_authorizer_uri, value: '', description: '')

control 'aws-apigateway-authorizers' do
  title 'Ensure API Gateway Authorizer resource has the correct properties.'

  describe aws_apigateway_authorizers(rest_api_id: aws_api_gateway_rest_api_id) do
    it { should exist }
  end

  describe aws_apigateway_authorizers(rest_api_id: aws_api_gateway_rest_api_id) do
    its('ids') { should include aws_api_gateway_authorizer_id }
    its('names') { should include 'aws_api_gateway_authorizer_test_demo' }
    its('types') { should include 'TOKEN' }
    its('provider_arns') { should_not be_empty }
    its('auth_types') { should include 'custom' }
    its('authorizer_uris') { should include aws_api_gateway_authorizer_authorizer_uri }
    its('authorizer_credentials') { should include aws_api_gateway_authorizer_authorizer_credentials }
    its('identity_sources') { should include 'method.request.header.Authorization' }
    its('identity_validation_expressions') { should_not be_empty }
    its('authorizer_result_ttl_in_seconds') { should include aws_api_gateway_authorizer_authorizer_result_ttl_in_seconds }
  end
end
