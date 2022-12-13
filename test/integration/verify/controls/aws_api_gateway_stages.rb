aws_api_gateway_deployement_id = input(:aws_api_gateway_deployement_id_test, value: '', description: '')
aws_api_gateway_stage_name = input(:aws_api_gateway_stage_name_test, value: '', description: '')
aws_api_gateway_client_certificate_id = input(:aws_api_gateway_client_certificate_id_test, value: '', description: '')
aws_api_gateway_rest_api_id = input(:aws_api_gateway_rest_api_id_test, value: '', description: '')

control 'aws-apigateway-stages' do
  title 'Ensure API Gateway Stages resource has the correct properties.'

  describe aws_api_gateway_stages(rest_api_id: aws_api_gateway_rest_api_id) do
    it { should exist }
  end
  
  describe aws_api_gateway_stages(rest_api_id: aws_api_gateway_rest_api_id) do
    its('deployment_ids') { should include aws_api_gateway_deployement_id }
    its('stage_names') { should include aws_api_gateway_stage_name }
    its('descriptions') { should_not be_empty }
  end
  
  describe aws_api_gateway_stages(rest_api_id: 'dummy') do
    it { should_not exist }
  end
end
