title 'Test single AWS DHCP Options'

aws_vpc_dhcp_options_id = input(:aws_vpc_dhcp_options_id, value: '', description: 'The AWS DHCP Options ID.')
aws_vpc_dhcp_options_name = input(:aws_vpc_dhcp_options_name, value: '', description: 'The AWS DHCP Options Name.')
aws_vpc_id = input(:aws_vpc_id, value: '', description: 'The AWS VPC ID.')

control 'aws-dhcp-options-1.0' do
  title 'Ensure AWS DHCP Options has the correct properties.'

  describe aws_dhcp_options(dhcp_options_id:  aws_vpc_dhcp_options_id) do
    it { should exist }
    its ('dhcp_options_id') { should eq aws_vpc_dhcp_options_id }
    its ('domain_name_servers') { should include('AmazonProvidedDNS') }
    its ('ntp_servers') { should include('127.0.0.1') }
    its ('tags') { should include('Name' => aws_vpc_dhcp_options_name) }
  end

  describe aws_dhcp_options(aws_vpc_dhcp_options_id) do
    it { should exist }
    its ('dhcp_options_id') { should eq aws_vpc_dhcp_options_id }
  end

  describe aws_vpc(vpc_id: aws_vpc_id) do
    its ('dhcp_options_id') { should eq aws_vpc_dhcp_options_id }
  end
end
