aws_api_gateway_vpc_link_id = attribute(:aws_api_gateway_vpc_link_id, value: '', description: '')
aws_api_gateway_vpc_link_name = attribute(:aws_api_gateway_vpc_link_name, value: '', description: '')
aws_api_gateway_vpc_link_description = attribute(:aws_api_gateway_vpc_link_description, value: '', description: '')
aws_api_gateway_vpc_link_target_arns = attribute(:aws_api_gateway_vpc_link_target_arns, value: '', description: '')
aws_api_gateway_status = attribute(:aws_api_gateway_status, value: '', description: '')
aws_api_gateway_status_message = attribute(:aws_api_gateway_status_message, value: '', description: '')

control 'aws-api-gateway-vpc-links-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway vpc links.'

  describe aws_api_gateway_vpc_links do
    it { should exist }
  end

  describe aws_api_gateway_vpc_links do
    its ('ids') { should include aws_api_gateway_vpc_link_id }
    its ('names') { should include aws_api_gateway_vpc_link_name }
    its ('descriptions') { should include aws_api_gateway_vpc_link_description }
    its ('target_arns') { should include aws_api_gateway_vpc_link_target_arns }
    its ('statuses') { should include aws_api_gateway_status }
    its ('status_messages') { should include aws_api_gateway_status_message }
    its ('tags') { should be_empty }
  end
end