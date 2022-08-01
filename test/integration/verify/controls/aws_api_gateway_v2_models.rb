aws_apigatewayv2_model_api_id = input(:aws_apigatewayv2_model_api_id, value: '', description: '')
aws_apigatewayv2_model_content_type = input(:aws_apigatewayv2_model_content_type, value: 'application/json', description: '')
aws_apigatewayv2_model_id = input(:aws_apigatewayv2_model_id, value: '', description: '')
aws_apigatewayv2_model_name = input(:aws_apigatewayv2_model_name, value: 'example', description: '')

control 'aws-api-gateway-v2-models-v-1-0-0' do
  impact 1.0
  title 'Ensure API Gateway API Models resource has the correct properties.'
  
  describe aws_api_gateway_v2_models(api_id: aws_apigatewayv2_model_api_id) do
    it { should exist }
  end

  describe aws_api_gateway_v2_models(api_id: aws_apigatewayv2_model_api_id) do
    its('content_types') { should include aws_apigatewayv2_model_content_type }
    its('descriptions') { should be_empty }
    its('model_ids') { should include aws_apigatewayv2_model_id }
    its('names') { should include aws_apigatewayv2_model_name }
    its('schemas') { should_not be_empty }
  end
end
