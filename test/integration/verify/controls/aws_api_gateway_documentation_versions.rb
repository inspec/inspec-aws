aws_api_gateway_rest_api_id = input(:aws_api_gateway_rest_api_id_1, value: '', description: '')
documentation_version_id = input(:aws_api_gateway_documentation_version_id, value: '', description: '')
aws_api_gateway_documentation_version_description = input(:aws_api_gateway_documentation_version_description, value: '', description: '')
start_index = documentation_version_id.index("/")
aws_api_gateway_documentation_version_id = documentation_version_id[start_index..]

control 'aws-api-gateway-documentation-versions-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway documentation versions.'

  describe aws_api_gateway_documentation_versions(rest_api_id: aws_api_gateway_rest_api_id) do
    it { should exist }
  end

  describe aws_api_gateway_documentation_versions(rest_api_id: aws_api_gateway_rest_api_id) do
    its ('versions') { should include aws_api_gateway_documentation_version_id }
    its ('created_dates') { should_not be_empty }
    its ('descriptions')  { should include aws_api_gateway_documentation_version_description }
  end

  describe aws_api_gateway_documentation_versions(rest_api_id: aws_api_gateway_rest_api_id) do
    it { should_not exist }
  end
end
