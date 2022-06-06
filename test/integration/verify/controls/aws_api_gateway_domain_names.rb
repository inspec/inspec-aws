aws_api_gateway_rest_api_id = attribute(:aws_api_gateway_rest_api_id, value: '', description: '')
aws_api_gateway_resource_id = attribute(:aws_api_gateway_resource_id, value: '', description: '')
aws_api_gateway_resource_parent_id = attribute(:aws_api_gateway_resource_parent_id, value: '', description: '')
aws_api_gateway_resource_path = attribute(:aws_api_gateway_resource_path, value: '', description: '')
aws_api_gateway_resource_path_part = attribute(:aws_api_gateway_resource_path_part, value: '', description: '')

control 'aws-api-gateway-resource-1.0' do
  impact 1.0
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
end