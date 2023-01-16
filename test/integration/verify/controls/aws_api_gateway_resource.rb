aws_api_gateway_rest_api_id = input(:aws_api_gateway_rest_api_id, value: '', description: 'The string identifier of the associated RestApi.')
aws_api_gateway_resource_id = input(:aws_api_gateway_resource_id, value: '', description: 'The identifier for the Resource resource.')
aws_api_gateway_resource_parent_id = input(:aws_api_gateway_resource_parent_id, value: '', description: 'The parent resource identifier.')
aws_api_gateway_resource_path = input(:aws_api_gateway_resource_path, value: '', description: 'The full path for this resource.')
aws_api_gateway_resource_path_part = input(:aws_api_gateway_resource_path_part, value: '', description: 'The last path segment for this resource.')

control 'aws-api-gateway-resource-1.0' do
  title 'Test the properties of the api gateway resource.'

  describe aws_api_gateway_resource(rest_api_id: aws_api_gateway_rest_api_id, resource_id: aws_api_gateway_resource_id) do
    it { should exist }
  end

  describe aws_api_gateway_resource(rest_api_id: aws_api_gateway_rest_api_id, resource_id: aws_api_gateway_resource_id) do
    its ('id') { should eq aws_api_gateway_resource_id }
    its ('parent_id') { should eq aws_api_gateway_resource_parent_id }
    its ('path_part') { should eq aws_api_gateway_resource_path_part }
    its ('path') { should eq aws_api_gateway_resource_path }
  end

  describe aws_api_gateway_resource(rest_api_id: aws_api_gateway_rest_api_id, resource_id: aws_api_gateway_resource_id) do
    its ('resource_methods') { should be_empty }
  end

  describe aws_api_gateway_resource(rest_api_id: 'dummy', resource_id: 'dummy') do
    it { should_not exist }
  end
end
