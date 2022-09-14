aws_api_gateway_rest_api_id = input(:aws_api_gateway_rest_api_id, value: '', description: '')

control 'aws-api-gateway-restapi-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway restapi.'

  describe aws_api_gateway_restapi(rest_api_id: aws_api_gateway_rest_api_id) do
    it { should exist }
  end

  describe aws_api_gateway_restapi(rest_api_id: aws_api_gateway_rest_api_id) do
    its('id') { should eq aws_api_gateway_rest_api_id }
    its('name') { should eq 'deployment1' }
    its('description') { should be_empty }
    its('version') { should be_empty }
    its('warnings') { should be_empty }
    its('binary_media_types') { should be_empty }
    its('minimum_compression_size') { should be_empty }
    its('api_key_source') { should_not be_empty }
    its('endpoint_configuration.types') { should eq ["PRIVATE"] }
    its('endpoint_configuration.vpc_endpoint_ids') { should be_empty }
    its('policy') { should_not be_empty }
    its('tags') { should be_empty }
    its('disable_execute_api_endpoint') { should eq false }
  end
end