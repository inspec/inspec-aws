aws_apigatewayv2_integration_response_api_id = input(:aws_apigatewayv2_integration_response_api_id, value: '', description: '')
aws_apigatewayv2_integration_response_id = input(:aws_apigatewayv2_integration_response_id, value: '', description: '')
aws_apigatewayv2_integration_response_integration_id = input(:aws_apigatewayv2_integration_response_integration_id, value: '', description: '')
aws_apigatewayv2_integration_response_integration_response_key = input(:aws_apigatewayv2_integration_response_integration_response_key, value: '', description: '')

control 'aws-api-gateway-v2-integration-responses-v-1.0.0' do
  title 'Ensure API Gateway API Integration Responses resource has the correct properties.'

  describe aws_api_gateway_v2_integration_responses(api_id: aws_apigatewayv2_integration_response_api_id, integration_id: aws_apigatewayv2_integration_response_integration_id) do
    it { should exist }
  end

  describe aws_api_gateway_v2_integration_responses(api_id: aws_apigatewayv2_integration_response_api_id, integration_id: aws_apigatewayv2_integration_response_integration_id) do
    its('content_handling_strategies') { should be_empty }
    its('integration_response_ids') { should include aws_apigatewayv2_integration_response_id }
    its('integration_response_keys') { should include aws_apigatewayv2_integration_response_integration_response_key }
    its('response_parameters') { should be_empty }
    its('response_templates') { should be_empty }
    its('template_selection_expressions') { should should be_empty }
  end
end
