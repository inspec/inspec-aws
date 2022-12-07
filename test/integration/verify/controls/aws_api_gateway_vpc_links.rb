aws_api_gateway_vpc_link_id = input(:aws_api_gateway_vpc_link_id, value: '', description: 'The identifier of the VpcLink.')
aws_api_gateway_vpc_link_name = input(:aws_api_gateway_vpc_link_name, value: '', description: 'The name used to label and identify the VPC link.')
aws_api_gateway_vpc_link_description = input(:aws_api_gateway_vpc_link_description, value: '', description: 'The description of the VPC link.')
aws_api_gateway_vpc_link_target_arns = input(:aws_api_gateway_vpc_link_target_arns, value: '', description: 'The ARN of the network load balancer of the VPC targeted by the VPC link.')
aws_api_gateway_status = input(:aws_api_gateway_status, value: '', description: 'The status of the VPC link.')
aws_api_gateway_status_message = input(:aws_api_gateway_status_message, value: '', description: 'A description about the VPC link status.')

control 'aws-api-gateway-vpc-links-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway VPC links.'

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
