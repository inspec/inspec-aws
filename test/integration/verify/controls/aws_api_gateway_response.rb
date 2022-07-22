aws_api_gateway_gateway_response_response_type = input(:aws_api_gateway_gateway_response_response_type, value: '', description: '')
aws_api_gateway_gateway_response_rest_api_id = input(:aws_api_gateway_gateway_response_rest_api_id, value: '', description: '')

control 'aws-api-gateway-response-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway response.'

  describe aws_api_gateway_response(rest_api_id: aws_api_gateway_gateway_response_rest_api_id, response_type: aws_api_gateway_gateway_response_response_type) do
    it { should exist }
  end

  describe aws_api_gateway_response(rest_api_id: aws_api_gateway_gateway_response_rest_api_id, response_type: aws_api_gateway_gateway_response_response_type) do
    its('response_type') { should eq aws_api_gateway_gateway_response_response_type }
    its('status_code') { should eq '401' }
    its('default_response') { should eq false }
  end
end