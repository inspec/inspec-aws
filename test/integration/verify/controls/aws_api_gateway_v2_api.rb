aws_apigatewayv2_api_id = attribute(:aws_apigatewayv2_api_id, value: '', description: '')
aws_apigatewayv2_api_api_endpoint = attribute(:aws_apigatewayv2_api_api_endpoint, value: '', description: '')
aws_apigatewayv2_api_api_key_selection_expression = attribute(:aws_apigatewayv2_api_api_key_selection_expression, value: '', description: '')
aws_apigatewayv2_api_description = attribute(:aws_apigatewayv2_api_description, value: '', description: '')
aws_apigatewayv2_api_disable_execute_api_endpoint = attribute(:aws_apigatewayv2_api_disable_execute_api_endpoint, value: false, description: '')
aws_apigatewayv2_api_name = attribute(:aws_apigatewayv2_api_name, value: '', description: '')
aws_apigatewayv2_api_protocol_type = attribute(:aws_apigatewayv2_api_protocol_type, value: '', description: '')
aws_apigatewayv2_api_route_selection_expression = attribute(:aws_apigatewayv2_api_route_selection_expression, value: '', description: '')

control 'aws-api-gateway-v2-api' do
  title 'Ensure API Gateway API resource has the correct properties.'
  
  describe aws_api_gateway_v2_api(api_id: aws_apigatewayv2_api_id) do
    it { should exist }
  end
  
  describe aws_api_gateway_v2_api(api_id: aws_apigatewayv2_api_id) do
    its('api_endpoint') { should eq aws_apigatewayv2_api_api_endpoint }
    its('api_gateway_managed') { should be_empty }
    its('api_id') { should eq aws_apigatewayv2_api_id }
    its('api_key_selection_expression') { should eq aws_apigatewayv2_api_api_key_selection_expression }
    its('cors_configuration.allow_credentials') { should be_empty }
    its('cors_configuration.allow_headers') { should be_empty }
    its('cors_configuration.allow_methods') { should be_empty }
    its('cors_configuration.expose_headers') { should be_empty }
    its('cors_configuration.max_age') { should be_empty }
    its('description') { should eq aws_apigatewayv2_api_description }
    its('disable_schema_validation') { should be_empty }
    its('disable_execute_api_endpoint') { should eq aws_apigatewayv2_api_disable_execute_api_endpoint }
    its('import_info') { should be_empty }
    its('name') { should eq aws_apigatewayv2_api_name }
    its('protocol_type') { should eq aws_apigatewayv2_api_protocol_type }
    its('route_selection_expression') { should eq aws_apigatewayv2_api_route_selection_expression }
    its('tags') { should be_empty }
    its('version') { should be_empty }
    its('warnings') { should be_empty }
  end

  describe aws_api_gateway_v2_api(api_id: 'no-api') do
    it { should_not exist }
  end
end
