aws_apigatewayv2_authorizer_id = input(:aws_apigatewayv2_authorizer_id, value: '', description: 'The authorizer identifier.')
aws_apigatewayv2_authorizer_api_id = input(:aws_apigatewayv2_authorizer_api_id, value: '', description: 'The API identifier.')
aws_apigatewayv2_authorizer_authorizer_type = input(:aws_apigatewayv2_authorizer_authorizer_type, value: '', description: 'The authorizer type.')
aws_apigatewayv2_authorizer_identity_sources = input(:aws_apigatewayv2_authorizer_identity_sources, value: '', description: 'The identity source for which authorization is requested.')
aws_apigatewayv2_authorizer_name = input(:aws_apigatewayv2_authorizer_name, value: '', description: 'The authorizer name.')

control 'aws-api-gateway-v2-api-authorizers' do
  impact 1.0
  title 'Ensure API Gateway API Authorizers resource has the correct properties.'
  
  describe aws_api_gateway_v2_authorizers(api_id: aws_apigatewayv2_authorizer_api_id) do
    it { should exist }
  end
  
  describe aws_api_gateway_v2_authorizers(api_id: aws_apigatewayv2_authorizer_api_id) do
    its('count') { should >= 1 }
  end
  
  describe aws_api_gateway_v2_authorizers(api_id: aws_apigatewayv2_authorizer_api_id) do
    its('authorizer_credentials_arns') { should be_empty }
    its('authorizer_ids') { should include aws_apigatewayv2_authorizer_id }
    its('authorizer_result_ttl_in_seconds') { should be_empty }
    its('authorizer_types') { should include aws_apigatewayv2_authorizer_authorizer_type }
    its('authorizer_uris') { should be_empty }
    its('identity_sources') { should include aws_apigatewayv2_authorizer_identity_sources }
    its('identity_validation_expressions') { should be_empty }
    its('jwt_configurations') { should_not be_empty }
    its('names') { should include aws_apigatewayv2_authorizer_name }
    its('authorizer_payload_format_versions') { should be_empty }
    its('enable_simple_responses') { should be_empty }
  end

  describe aws_api_gateway_v2_authorizers(api_id: 'dummy') do
    it { should_not exist }
  end
end




