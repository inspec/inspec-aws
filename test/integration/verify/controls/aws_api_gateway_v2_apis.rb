aws_apigatewayv2_api_id = attribute(:aws_apigatewayv2_api_id, value: '', description: '')
aws_apigatewayv2_api_api_endpoint = attribute(:aws_apigatewayv2_api_api_endpoint, value: '', description: '')
aws_apigatewayv2_api_api_key_selection_expression = attribute(:aws_apigatewayv2_api_api_key_selection_expression, value: '', description: '')
aws_apigatewayv2_api_description = attribute(:aws_apigatewayv2_api_description, value: '', description: '')
aws_apigatewayv2_api_disable_execute_api_endpoint = attribute(:aws_apigatewayv2_api_disable_execute_api_endpoint, value: false, description: '')
aws_apigatewayv2_api_name = attribute(:aws_apigatewayv2_api_name, value: '', description: '')
aws_apigatewayv2_api_protocol_type = attribute(:aws_apigatewayv2_api_protocol_type, value: '', description: '')
aws_apigatewayv2_api_route_selection_expression = attribute(:aws_apigatewayv2_api_route_selection_expression, value: '', description: '')

control 'aws-api-gateway-v2-apis' do
  impact 1.0
  title 'Ensure API Gateway APIs resource has the correct properties.'
  
  describe aws_api_gateway_v2_apis do
    it { should exist }
  end
  
  describe aws_api_gateway_v2_apis do
    its('api_endpoints') { should include aws_apigatewayv2_api_api_endpoint }
    its('api_gateway_manageds') { should be_empty }
    its('api_ids') { should include aws_apigatewayv2_api_id }
    its('api_key_selection_expressions') { should include aws_apigatewayv2_api_api_key_selection_expression }
    its('cors_configurations') { should_not be_empty }
    its('descriptions') { should include aws_apigatewayv2_api_description }
    its('disable_schema_validations') { should be_empty }
    its('disable_execute_api_endpoints') { should include aws_apigatewayv2_api_disable_execute_api_endpoint }
    its('import_infos') { should be_empty }
    its('names') { should include aws_apigatewayv2_api_name }
    its('protocol_types') { should include aws_apigatewayv2_api_protocol_type }
    its('route_selection_expressions') { should include aws_apigatewayv2_api_route_selection_expression }
    its('tags') { should_not be_empty }
    its('versions') { should be_empty }
    its('warnings') { should be_empty }
  end
end
