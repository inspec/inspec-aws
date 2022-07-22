aws_api_gateway_model_id = input(:aws_api_gateway_model_id, value: '', description: '')
aws_api_gateway_model_name = input(:aws_api_gateway_model_name, value: '', description: '')
aws_api_gateway_model_content_type = input(:aws_api_gateway_model_content_type, value: '', description: '')
aws_api_gateway_model_description = input(:aws_api_gateway_model_description, value: '', description: '')
aws_api_gateway_model_rest_api_id = input(:aws_api_gateway_model_rest_api_id, value: '', description: '')

control 'aws-api-gateway-models-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway models.'

  describe aws_api_gateway_models(rest_api_id: aws_api_gateway_model_rest_api_id) do
    it { should exist }
  end

  describe aws_api_gateway_models(rest_api_id: aws_api_gateway_model_rest_api_id) do
    its('ids') { should include aws_api_gateway_model_id }
    its('content_types') { should include aws_api_gateway_model_content_type }
    its('descriptions') { should include aws_api_gateway_model_description }
    its('names') { should include aws_api_gateway_model_name }
    its('schemas') { should_not be_empty }
  end
end
