aws_api_gateway_gateway_response_response_type = input(:aws_api_gateway_gateway_response_response_type, value: '', description: '')
aws_api_gateway_gateway_response_rest_api_id = input(:aws_api_gateway_gateway_response_rest_api_id, value: '', description: '')

control 'aws-api-gateway-responses-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway responses.'

  describe aws_api_gateway_responses(rest_api_id: aws_api_gateway_gateway_response_rest_api_id) do
    it { should exist }
  end

  describe aws_api_gateway_responses(rest_api_id: aws_api_gateway_gateway_response_rest_api_id) do
    its('response_types') { should include aws_api_gateway_gateway_response_response_type }
    its('status_codes') { should include '401' }
    its('default_responses') { should include false }
  end
end