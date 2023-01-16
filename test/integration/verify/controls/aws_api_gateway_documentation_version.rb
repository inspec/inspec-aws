aws_api_gateway_rest_api_id = input(:aws_api_gateway_rest_api_id_1, value: '', description: '')
documentation_version_id = input(:aws_api_gateway_documentation_version_id, value: '', description: '')
aws_api_gateway_documentation_version_description = input(:aws_api_gateway_documentation_version_description, value: '', description: '')
start_index = documentation_version_id.index("/")
aws_api_gateway_documentation_version_id = documentation_version_id[start_index..]

control 'aws-api-gateway-documentation-version-1.0' do
  title 'Test the properties of the api gateway documentation version.'

  describe aws_api_gateway_documentation_version(rest_api_id: aws_api_gateway_rest_api_id, documentation_version: aws_api_gateway_documentation_version_id) do
    it { should exist }
  end

  describe aws_api_gateway_documentation_version(rest_api_id: aws_api_gateway_rest_api_id, documentation_version: aws_api_gateway_documentation_version_id) do
    its ('version') { should eq aws_api_gateway_documentation_version_id }
    its ('description')  { should eq aws_api_gateway_documentation_version_description }
  end

  describe aws_api_gateway_documentation_version(rest_api_id: 'dummy', documentation_version: 'dummy') do
    it { should_not exist }
  end
end
