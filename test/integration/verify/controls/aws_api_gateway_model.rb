aws_api_gateway_model_id = input(:aws_api_gateway_model_id, value: '', description: '')
aws_api_gateway_model_name = input(:aws_api_gateway_model_name, value: '', description: '')
aws_api_gateway_model_content_type = input(:aws_api_gateway_model_content_type, value: '', description: '')
aws_api_gateway_model_description = input(:aws_api_gateway_model_description, value: '', description: '')
aws_api_gateway_model_rest_api_id = input(:aws_api_gateway_model_rest_api_id, value: '', description: '')

control 'aws-api-gateway-model-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway model.'

  describe aws_api_gateway_model(rest_api_id: aws_api_gateway_model_rest_api_id, model_name: aws_api_gateway_model_name) do
    it { should exist }
  end

  describe aws_api_gateway_model(rest_api_id: aws_api_gateway_model_rest_api_id, model_name: aws_api_gateway_model_name) do
    its('content_type') { should eq aws_api_gateway_model_content_type }
    its('description') { should eq aws_api_gateway_model_description }
    its('id') { should eq aws_api_gateway_model_id }
    its('name') { should eq aws_api_gateway_model_name }
    its('schema') { should_not be_empty }
  end
end
