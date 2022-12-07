title 'Test single AWS Ec2 DHCP Option'

aws_vpc_dhcp_options_id = input(:aws_vpc_dhcp_options_id, value: '', description: 'The AWS EC2 DHCP Option ID.')
aws_vpc_dhcp_options_name = input(:aws_vpc_dhcp_options_name, value: '', description: 'The AWS EC2 DHCP Option Name.')

control 'aws-ec2-dhcp-option-1.0' do
  impact 1.0
  title 'Ensure AWS EC2 DHCP Option has the correct properties.'

  describe aws_ec2_dhcp_option(dhcp_options_id: aws_vpc_dhcp_options_id) do
    it { should exist }
    its('dhcp_options_id') { should eq aws_vpc_dhcp_options_id }
    its('domain_name_servers') { should include('AmazonProvidedDNS') }
    its('ntp_servers') { should include('127.0.0.1') }
    its('tags') { should include('Name' => aws_vpc_dhcp_options_name) }
  end

  describe aws_ec2_dhcp_option(aws_vpc_dhcp_options_id) do
    it { should exist }
    its('dhcp_options_id') { should eq aws_vpc_dhcp_options_id }
  end
end
