title 'Ensure API Gateway API Deployments resource has the correct properties.'

aws_apigatewayv2_deployment_api_id = input(:aws_apigatewayv2_deployment_api_id, value: '', description: '')
aws_apigatewayv2_deployment_auto_deployed = input(:aws_apigatewayv2_deployment_auto_deployed, value: false, description: '')
aws_apigatewayv2_deployment_description = input(:aws_apigatewayv2_deployment_description, value: '', description: '')
aws_apigatewayv2_deployment_id = input(:aws_apigatewayv2_deployment_id, value: '', description: '')

control 'aws-api-gateway-v2-deployments-v1.0.0' do
  title 'Ensure API Gateway API Deployments resource has the correct properties.'
  desc 'Ensure API Gateway API Deployments resource has the correct properties.'
  
  describe aws_api_gateway_v2_deployments(api_id: aws_apigatewayv2_deployment_api_id) do
    it { should exist }
  end
  
  describe aws_api_gateway_v2_deployments(api_id: aws_apigatewayv2_deployment_api_id) do
    its('auto_deployeds') { should include aws_apigatewayv2_deployment_auto_deployed }
    its('deployment_ids') { should include aws_apigatewayv2_deployment_id }
    its('deployment_statuses') { should include 'DEPLOYED' }
    its('deployment_status_messages') { should be_empty }
    its('descriptions') { should include aws_apigatewayv2_deployment_description }
  end
end
