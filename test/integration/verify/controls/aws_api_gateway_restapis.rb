aws_api_gateway_rest_api_id = input(:aws_api_gateway_rest_api_id, value: '', description: '')

control 'aws-api-gateway-restapis-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway restapis.'

  describe aws_api_gateway_restapis do
    it { should exist }
  end
  
  describe aws_api_gateway_restapis do
    its('ids') { should include aws_api_gateway_rest_api_id }
    its('names') { should include 'deployment1' }
    its('descriptions') { should_not be_empty }
    its('versions') { should_not be_empty }
    its('warnings') { should_not be_empty }
    its('binary_media_types') { should_not be_empty }
    its('minimum_compression_sizes') { should_not be_empty }
    its('api_key_sources') { should_not be_empty }
    its('endpoint_configurations') { should_not be_empty }
    its('policy') { should be_empty }
    its('tags') { should_not be_empty }
    its('disable_execute_api_endpoints') { should include false }
  end
end

