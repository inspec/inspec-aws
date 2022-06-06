aws_api_gateway_vpc_link_id = attribute(:aws_api_gateway_vpc_link_id, value: '', description: '')
aws_api_gateway_vpc_link_name = attribute(:aws_api_gateway_vpc_link_name, value: '', description: '')
aws_api_gateway_vpc_link_description = attribute(:aws_api_gateway_vpc_link_description, value: '', description: '')
aws_api_gateway_vpc_link_target_arns = attribute(:aws_api_gateway_vpc_link_target_arns, value: '', description: '')
aws_api_gateway_status = attribute(:aws_api_gateway_status, value: 'AVAILABLE', description: '')
aws_api_gateway_status_message = attribute(:aws_api_gateway_status_message, value: 'Your vpc link is ready for use', description: '')

control 'aws-api-gateway-vpc-link-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway vpc link.'

  describe aws_api_gateway_vpc_link(vpc_link_id: aws_api_gateway_vpc_link_id) do
    it { should exist }
  end

  describe aws_api_gateway_vpc_link(vpc_link_id: aws_api_gateway_vpc_link_id) do
    its ('id') { should eq aws_api_gateway_vpc_link_id }
    its ('name') { should eq aws_api_gateway_vpc_link_name }
    its ('description') { should eq aws_api_gateway_vpc_link_description }
    its ('target_arns') { should eq [aws_api_gateway_vpc_link_target_arns] }
    its ('target_arns') { should include aws_api_gateway_vpc_link_target_arns }
    its ('status') { should eq aws_api_gateway_status }
    its ('status_message') { should eq aws_api_gateway_status_message }
    its ('tags') { should be_empty }
  end
end