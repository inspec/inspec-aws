aws_apigatewayv2_authorizer_id = input(:aws_apigatewayv2_authorizer_id, value: '', description: 'The authorizer identifier.')
aws_apigatewayv2_authorizer_api_id = input(:aws_apigatewayv2_authorizer_api_id, value: '', description: 'The API identifier.')
aws_apigatewayv2_authorizer_authorizer_type = input(:aws_apigatewayv2_authorizer_authorizer_type, value: '', description: 'The authorizer type.')
aws_apigatewayv2_authorizer_identity_sources = input(:aws_apigatewayv2_authorizer_identity_sources, value: '', description: 'The identity source for which authorization is requested.')
aws_apigatewayv2_authorizer_jwt_configuration_audience = input(:aws_apigatewayv2_authorizer_jwt_configuration_audience, value: '', description: 'The authorizer JWT configuration audience.')
aws_apigatewayv2_authorizer_jwt_configuration_issuer = input(:aws_apigatewayv2_authorizer_jwt_configuration_issuer, value: '', description: 'The authorizer JWT configuration issuer.')
aws_apigatewayv2_authorizer_name = input(:aws_apigatewayv2_authorizer_name, value: '', description: 'The authorizer name.')

control 'aws-api-gateway-v2-api-authorizer' do
  title 'Ensure API Gateway API Authorizer resource has the correct properties.'
  
  describe aws_api_gateway_v2_authorizer(api_id: aws_apigatewayv2_authorizer_api_id, authorizer_id: aws_apigatewayv2_authorizer_id) do
    it { should exist }
  end
  
  describe aws_api_gateway_v2_authorizer(api_id: aws_apigatewayv2_authorizer_api_id, authorizer_id: aws_apigatewayv2_authorizer_id) do
    its('authorizer_credentials_arn') { should be_empty }
    its('authorizer_id') { should eq aws_apigatewayv2_authorizer_id }
    its('authorizer_result_ttl_in_seconds') { should be_empty }
    its('authorizer_type') { should eq aws_apigatewayv2_authorizer_authorizer_type }
    its('authorizer_uri') { should be_empty }
    its('identity_source') { should include aws_apigatewayv2_authorizer_identity_sources }
    its('identity_validation_expression') { should be_empty }
    its('jwt_configuration.audience') { should include aws_apigatewayv2_authorizer_jwt_configuration_audience }
    its('jwt_configuration.issuer') { should eq aws_apigatewayv2_authorizer_jwt_configuration_issuer }
    its('name') { should eq aws_apigatewayv2_authorizer_name }
    its('authorizer_payload_format_version') { should be_empty }
    its('enable_simple_responses') { should be_empty }
  end

  describe aws_api_gateway_v2_authorizer(api_id: aws_apigatewayv2_authorizer_api_id, authorizer_id: 'dummy') do
    it { should_not exist }
  end
end
