aws_apigatewayv2_api_mapping_id = input(:aws_apigatewayv2_api_mapping_id, value: '', description: '')
aws_apigatewayv2_api_mapping_domain_name = input(:aws_apigatewayv2_api_mapping_domain_name, value: '', description: '')
aws_apigatewayv2_api_mapping_api_id = input(:aws_apigatewayv2_api_mapping_api_id, value: '', description: '')
aws_apigatewayv2_api_mapping_api_mapping_key = input(:aws_apigatewayv2_api_mapping_api_mapping_key, value: '', description: '')
aws_apigatewayv2_api_mapping_stage = input(:aws_apigatewayv2_api_mapping_stage, value: '', description: '')

control 'aws-api-gateway-v2-api-mappings' do
  impact 1.0
  title 'Ensure API Gateway API Mappings resource has the correct properties.'
  
  describe aws_api_gateway_v2_api_mappings(domain_name: aws_apigatewayv2_api_mapping_domain_name) do
    it { should exist }
  end
  
  describe aws_api_gateway_v2_api_mappings(domain_name: aws_apigatewayv2_api_mapping_domain_name) do
    its('api_ids') { should include aws_apigatewayv2_api_mapping_api_id }
    its('api_mapping_ids') { should include aws_apigatewayv2_api_mapping_id }
    its('api_mapping_keys') { should include aws_apigatewayv2_api_mapping_api_mapping_key }
    its('stages') { should include aws_apigatewayv2_api_mapping_stage }
  end
end
