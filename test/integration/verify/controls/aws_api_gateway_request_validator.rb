aws_api_gateway_request_validator_rest_api_id = input(:aws_api_gateway_request_validator_rest_api_id, value: '', description: '')
aws_api_gateway_request_validator_id = input(:aws_api_gateway_request_validator_id, value: '', description: '')
aws_api_gateway_request_validator_name = input(:aws_api_gateway_request_validator_name, value: '', description: '')
aws_api_gateway_request_validator_validate_request_body = input(:aws_api_gateway_request_validator_validate_request_body, value: true, description: '')
aws_api_gateway_request_validator_validate_request_parameters = input(:aws_api_gateway_request_validator_validate_request_body, value: false, description: '')

control 'aws-api-gateway-request-validator-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway request validator.'

  describe aws_api_gateway_request_validator(rest_api_id: aws_api_gateway_request_validator_rest_api_id, request_validator_id: aws_api_gateway_request_validator_id) do
    it { should exist }
  end

  describe aws_api_gateway_request_validator(rest_api_id: aws_api_gateway_request_validator_rest_api_id, request_validator_id: aws_api_gateway_request_validator_id) do
    its ('id') { should eq aws_api_gateway_request_validator_id }
    its ('name') { should eq aws_api_gateway_request_validator_name }
    its ('validate_request_body') { should eq aws_api_gateway_request_validator_validate_request_body }
    its ('validate_request_parameters') { should eq aws_api_gateway_request_validator_validate_request_parameters }
  end
end