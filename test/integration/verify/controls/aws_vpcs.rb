title 'Test AWS VPCs in bulk'

aws_vpc_id = input(:aws_vpc_id, value: '', description: 'The AWS VPC ID.')
aws_vpc_cidr_block = input(:aws_vpc_cidr_block, value: '', description: 'The AWS VPC CIDR block.')
aws_vpc_instance_tenancy = input(:aws_vpc_instance_tenancy, value: '', description: 'The AWS VPC instance tenancy option.')
aws_vpc_dhcp_options_id = input(:aws_vpc_dhcp_options_id, value: '', description: 'The AWS VPC DHCP options ID.')
aws_vpc_name = input(:aws_vpc_name, value: '', description: 'The AWS VPC name.')

control 'aws-vpcs-1.0' do
  impact 1.0
  title 'Ensure AWS VPC plural resource has the correct properties.'

  describe aws_vpcs do
    it { should exist }
    its('count')             { should be <= 100 }
    its('cidr_blocks')       { should include aws_vpc_cidr_block }
    its('vpc_ids')           { should include aws_vpc_id }
    its('states')            { should include 'available' }
    its('dhcp_options_ids')  { should include aws_vpc_dhcp_options_id }
    its('instance_tenancies') { should include aws_vpc_instance_tenancy }
    its('is_defaults')       { should be_in [true, false] }
    its('tags')              { should include('Name' => aws_vpc_name) }
    its('associated_cidr_blocks') { should include(aws_vpc_cidr_block) }
  end

  describe aws_vpcs.where { cidr_block_states.include?('associated') } do
    it { should exist }
  end

  describe aws_vpcs.where { ipv6_network_border_groups.include?('us-east-2a') } do
    it { should exist }
  end
end
