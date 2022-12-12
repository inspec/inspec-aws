aws_api_gateway_rest_api_id = input(:aws_api_gateway_rest_api_id, value: '', description: 'The string identifier of the associated RestApi.')
aws_api_gateway_resource_id = input(:aws_api_gateway_resource_id, value: '', description: 'The identifier for the Resource resource.')
aws_api_gateway_resource_parent_id = input(:aws_api_gateway_resource_parent_id, value: '', description: 'The parent resource identifier.')
aws_api_gateway_resource_path = input(:aws_api_gateway_resource_path, value: '', description: 'The full path for this resource.')
aws_api_gateway_resource_path_part = input(:aws_api_gateway_resource_path_part, value: '', description: 'The last path segment for this resource.')

control 'aws-api-gateway-resources-1.0' do
  title 'Test the properties of the api gateway resources.'

  describe aws_api_gateway_resources(rest_api_id: aws_api_gateway_rest_api_id) do
    it { should exist }
  end

  describe aws_api_gateway_resources(rest_api_id: aws_api_gateway_rest_api_id) do
    its ('ids') { should include aws_api_gateway_resource_id }
    its ('parent_ids') { should include aws_api_gateway_resource_parent_id }
    its ('path_parts') { should include aws_api_gateway_resource_path_part }
    its ('paths') { should include aws_api_gateway_resource_path }
    its ('resource_methods') { should be_empty }
  end

  describe aws_api_gateway_resources(rest_api_id: 'dummy') do
    it { should_not exist }
  end
end
