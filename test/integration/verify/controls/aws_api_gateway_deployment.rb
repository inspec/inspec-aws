aws_api_gateway_deployement_id = input(:aws_api_gateway_deployement_id, value: '', description: '')
aws_api_gateway_rest_api_id_test = input(:aws_api_gateway_rest_api_id_test, value: '', description: '')

control 'aws-api-gateway-deployment-1.0' do
  title 'Test the properties of the api gateway deployment.'

  describe aws_api_gateway_deployment(rest_api_id: aws_api_gateway_rest_api_id_test, deployment_id: aws_api_gateway_deployement_id) do
    it { should exist }
  end

  describe aws_api_gateway_deployment(rest_api_id: aws_api_gateway_rest_api_id_test, deployment_id: aws_api_gateway_deployement_id) do
    its('id') { should eq aws_api_gateway_deployement_id }
    its('description') { should eq 'test' }
    its('api_summary') { should be_empty }
  end

  describe aws_api_gateway_deployment(rest_api_id: 'dummy', deployment_id: 'dummy') do
    it { should_not exist }
  end
end
