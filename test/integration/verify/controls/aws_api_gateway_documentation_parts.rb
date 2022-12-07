aws_api_gateway_rest_api_id = input(:aws_api_gateway_rest_api_id_1, value: '', description: '')
documentation_part_id = input(:aws_api_gateway_documentation_part_id, value: '', description: '')
aws_api_gateway_documentation_part_location_type = input(:aws_api_gateway_documentation_part_location_type, value: '', description: '')
start_index = documentation_part_id.index("/")
aws_api_gateway_documentation_part_id = documentation_part_id[start_index..]

control 'aws-api-gateway-documentation-parts-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway documentation parts.'

  describe aws_api_gateway_documentation_parts(rest_api_id: aws_api_gateway_rest_api_id) do
    it { should exist }
  end

  describe aws_api_gateway_documentation_parts(rest_api_id: aws_api_gateway_rest_api_id) do
    its ('ids') { should include aws_api_gateway_documentation_part_id }
    its ('types') { should include aws_api_gateway_documentation_part_location_type }
    its ('paths') { should_not be_empty }
    its ('methods') { should_not be_empty }
    its ('status_codes') { should_not be_empty }
    its ('names') { should_not be_empty }
    its ('properties') { should_not be_empty }
  end

  describe aws_api_gateway_documentation_parts(rest_api_id: 'dummy') do
    it { should_not exist }
  end
end
