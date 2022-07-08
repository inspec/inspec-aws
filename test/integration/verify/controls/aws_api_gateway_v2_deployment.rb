title 'Ensure API Gateway API Deployment resource has the correct properties.'

aws_apigatewayv2_deployment_api_id = input(:aws_apigatewayv2_deployment_api_id, value: '', description: '')
aws_apigatewayv2_deployment_auto_deployed = input(:aws_apigatewayv2_deployment_auto_deployed, value: false, description: '')
aws_apigatewayv2_deployment_description = input(:aws_apigatewayv2_deployment_description, value: '', description: '')
aws_apigatewayv2_deployment_id = input(:aws_apigatewayv2_deployment_id, value: '', description: '')

control 'aws-api-gateway-v2-deployment-v1.0.0' do
  impact 1.0
  title 'Ensure API Gateway API Deployment resource has the correct properties.'
  desc 'Ensure API Gateway API Deployment resource has the correct properties.'

  describe aws_api_gateway_v2_deployment(api_id: aws_apigatewayv2_deployment_api_id, deployment_id: aws_apigatewayv2_deployment_id) do
    it { should exist }
  end

  describe aws_api_gateway_v2_deployment(api_id: aws_apigatewayv2_deployment_api_id, deployment_id: aws_apigatewayv2_deployment_id) do
    its('auto_deployed') { should eq aws_apigatewayv2_deployment_auto_deployed }
    its('deployment_id') { should eq aws_apigatewayv2_deployment_id }
    its('deployment_status') { should eq 'DEPLOYED' }
    its('deployment_status_message') { should be_empty }
    its('description') { should eq aws_apigatewayv2_deployment_description }
  end

  describe aws_api_gateway_v2_deployment(api_id: aws_apigatewayv2_deployment_api_id, deployment_id: 'dummy') do
    it { should_not exist }
  end
end
