title 'Test Collection of EC2 AWS DHCP Options'

aws_vpc_dhcp_options_id = input(:aws_vpc_dhcp_options_id, value: '', description: 'The AWS EC2 DHCP Options ID.')
aws_vpc_dhcp_options_name = input(:aws_vpc_dhcp_options_name, value: '', description: 'The AWS EC2 DHCP Options Name.')

control 'aws-ec2-dhcp-options-1.0' do
  impact 1.0
  title 'Ensure AWS EC2 DHCP Options has the correct properties.'

  aws_ec2_dhcp_options.each do |dhcp_option|
    describe aws_ec2_dhcp_option(dhcp_options_id: dhcp_option.dhcp_options_id) do
      it { should exist }
      its('dhcp_options_id') { should eq aws_vpc_dhcp_options_id }
      its('domain_name_servers') { should include('AmazonProvidedDNS') }
      its('ntp_servers') { should include('127.0.0.1') }
      its('tags') { should include('Name' => aws_vpc_dhcp_options_name) }
    end
  end

  describe aws_ec2_dhcp_options do
    it { should exist }
    its('dhcp_options_ids') { should include aws_vpc_dhcp_options_id }
    its('domain_name_servers') { should include('AmazonProvidedDNS') }
    its('ntp_servers') { should include('127.0.0.1') }
    its('tags') { should include('Name' => aws_vpc_dhcp_options_name) }
  end
end
