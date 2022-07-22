aws_apigatewayv2_integration_response_api_id = input(:aws_apigatewayv2_integration_response_api_id, value: '', description: '')
aws_apigatewayv2_integration_response_id = input(:aws_apigatewayv2_integration_response_id, value: '', description: '')
aws_apigatewayv2_integration_response_integration_id = input(:aws_apigatewayv2_integration_response_integration_id, value: '', description: '')
aws_apigatewayv2_integration_response_integration_response_key = input(:aws_apigatewayv2_integration_response_integration_response_key, value: '', description: '')

control 'aws-api-gateway-v2-integration-response-v-1.0.0' do
  impact 1.0
  title 'Ensure API Gateway API Integration Response resource has the correct properties.'
  
  describe aws_api_gateway_v2_integration_response(api_id: aws_apigatewayv2_integration_response_api_id, integration_id: aws_apigatewayv2_integration_response_integration_id, integration_response_id: aws_apigatewayv2_integration_response_id) do
    it { should exist }
  end
  
  describe aws_api_gateway_v2_integration_response(api_id: aws_apigatewayv2_integration_response_api_id, integration_id: aws_apigatewayv2_integration_response_integration_id, integration_response_id: aws_apigatewayv2_integration_response_id) do
    its('content_handling_strategy') { should be_empty }
    its('integration_response_id') { should eq aws_apigatewayv2_integration_response_id }
    its('integration_response_key') { should eq aws_apigatewayv2_integration_response_integration_response_key }
    its('response_parameters') { should be_empty }
    its('response_templates') { should be_empty }
    its('template_selection_expression') { should be_empty }
  end
end
