aws_api_gateway_deployement_id = attribute(:aws_api_gateway_deployement_id_test, value: '', description: '')
aws_api_gateway_stage_name = attribute(:aws_api_gateway_stage_name_test, value: '', description: '')
aws_api_gateway_client_certificate_id = attribute(:aws_api_gateway_client_certificate_id_test, value: '', description: '')
aws_api_gateway_rest_api_id = attribute(:aws_api_gateway_rest_api_id_test, value: '', description: '')

describe aws_api_gateway_stage(rest_api_id: aws_api_gateway_rest_api_id, stage_name: aws_api_gateway_stage_name) do
    it { should exist }
  end
  
  describe aws_api_gateway_stage(rest_api_id: aws_api_gateway_rest_api_id, stage_name: aws_api_gateway_stage_name) do
    its('deployment_id') { should eq aws_api_gateway_deployement_id }
    its('client_certificate_id') { should eq aws_api_gateway_client_certificate_id }
    its('stage_name') { should eq aws_api_gateway_stage_name }
  end
  
  describe aws_api_gateway_stage(rest_api_id: 'dummy', stage_name: 'dummy') do
    it { should_not exist }
  end
  