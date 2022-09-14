aws_apigatewayv2_route_api_id = input(:aws_apigatewayv2_route_api_id, value: '', description: '')
aws_apigatewayv2_route_api_key_required = input(:aws_apigatewayv2_route_api_key_required, value: false, description: '')
aws_apigatewayv2_route_authorization_scopes = input(:aws_apigatewayv2_route_authorization_scopes, value: '', description: '')
aws_apigatewayv2_route_authorization_type = input(:aws_apigatewayv2_route_authorization_type, value: 'NONE', description: '')
aws_apigatewayv2_route_authorizer_id = input(:aws_apigatewayv2_model_api_id, value: '', description: '')
aws_apigatewayv2_route_id = input(:aws_apigatewayv2_model_api_id, value: '', description: '')
aws_apigatewayv2_route_model_selection_expression = input(:aws_apigatewayv2_model_api_id, value: '', description: '')
aws_apigatewayv2_route_operation_name = input(:aws_apigatewayv2_model_api_id, value: '', description: '')
aws_apigatewayv2_route_route_key = input(:aws_apigatewayv2_model_api_id, value: '$default', description: '')
aws_apigatewayv2_route_target = input(:aws_apigatewayv2_model_api_id, value: '', description: '')
aws_apigatewayv2_route_request_models = input(:aws_apigatewayv2_model_api_id, value: '', description: '')
aws_apigatewayv2_route_request_parameter = input(:aws_apigatewayv2_route_request_parameter, value: '', description: '')

control 'aws-api-gateway-v2-routes' do
  impact 1.0
  title 'Ensure API Gateway API Routes resource has the correct properties.'
  
  describe aws_api_gateway_v2_routes(api_id: aws_apigatewayv2_route_api_id) do
    it { should exist }
  end

  describe aws_api_gateway_v2_routes(api_id: aws_apigatewayv2_route_api_id) do
    its('api_gateway_manageds') { should be_empty }
    its('api_key_requireds') { should include aws_apigatewayv2_route_api_key_required }
    its('authorization_scopes') { should be_empty }
    its('authorization_types') { should include aws_apigatewayv2_route_authorization_type }
    its('authorizer_ids') { should be_empty }
    its('model_selection_expressions') { should be_empty }
    its('operation_names') { should be_empty }
    its('request_models') { should be_empty }
    its('request_parameters') { should be_empty }
    its('route_ids') { should include aws_apigatewayv2_route_id }
    its('route_keys') { should include aws_apigatewayv2_route_route_key }
    its('route_response_selection_expressions') { should be_empty }
    its('targets') { should include aws_apigatewayv2_route_target }
  end
end