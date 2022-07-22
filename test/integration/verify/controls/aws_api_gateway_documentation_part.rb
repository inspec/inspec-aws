aws_api_gateway_rest_api_id = input(:aws_api_gateway_rest_api_id_1, value: '', description: '')
documentation_part_id = input(:aws_api_gateway_documentation_part_id, value: '', description: '')
aws_api_gateway_documentation_part_location_type = input(:aws_api_gateway_documentation_part_location_type, value: '', description: '')
start_index = documentation_part_id.index("/")
aws_api_gateway_documentation_part_id = documentation_part_id[start_index..]

control 'aws-api-gateway-documentation-part-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway documentation part.'

  describe aws_api_gateway_documentation_part(rest_api_id: aws_api_gateway_rest_api_id, documentation_part_id: aws_api_gateway_documentation_part_id) do
    it { should exist }
  end

  describe aws_api_gateway_documentation_part(rest_api_id: aws_api_gateway_rest_api_id, documentation_part_id: aws_api_gateway_documentation_part_id) do
    its ('id') { should eq aws_api_gateway_documentation_part_id }
    its ('location.type') { should eq aws_api_gateway_documentation_part_location_type }
    its ('location.path')  { should be_empty }
    its ('location.status_code') { should be_empty }
    its ('location.name') { should eq nil }
    its ('properties') { should_not be_empty }
  end
end
