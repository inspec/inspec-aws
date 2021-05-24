title 'Test AWS VPCs in bulk'

aws_vpc_id = attribute(:aws_vpc_id, value: '', description: 'The AWS VPC ID.')
aws_vpc_cidr_block = attribute(:aws_vpc_cidr_block, value: '', description: 'The AWS VPC CIDR block.')
aws_vpc_instance_tenancy = attribute(:aws_vpc_instance_tenancy, value: '', description: 'The AWS VPC instance tenancy option.')
aws_vpc_dhcp_options_id = attribute(:aws_vpc_dhcp_options_id, value: '', description: 'The AWS VPC DHCP options ID.')
aws_vpc_name = attribute(:aws_vpc_name, value: '', description: 'The AWS VPC name.')

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
    its('instance_tenancys') { should include aws_vpc_instance_tenancy }
    its('is_defaults')       { should be_in [true, false] }
    its('tags')              { should include('Name' => aws_vpc_name) }
  end
end

cidr_association_ids = attribute("cidr_association_ids", default: '', description: 'The association ID for a CIDR block associated with the VPC.')
cidr_states = attribute("cidr_states", default: '', description: 'The state of a CIDR block associated with the VPC.')
cidr_status_messages = attribute("cidr_status_messages", default: '', description: 'The status message of a CIDR block associated with the VPC.')

control 'aws-vpcs-1.0' do
  impact 1.0
  title 'Ensure AWS VPC CIDR Block plural resource has the correct properties.'
  describe aws_vpcs do
    its ('cidr_association_ids')        { should include cidr_association_ids }
    its ('cidr_states')                 { should include cidr_states }
    its ('cidr_status_messages')        { should be_empty }
  end
end

ipv_6_cidr_association_ids = attribute("ipv_6_cidr_association_ids", default: '', description: 'The association ID for a ipv6 CIDR block associated with the VPC.')
ipv_6_cidr_states = attribute("ipv_6_cidr_states", default: '', description: 'The state of a ipv6 CIDR block associated with the VPC.')
ipv_6_cidr_status_messages = attribute("ipv_6_cidr_status_messages", default: '', description: 'The status message of a ipv6 CIDR block associated with the VPC.')
ipv_6_cidr_network_border_groups = attribute("ipv_6_cidr_network_border_groups", default: '', description: 'The network border group of a ipv6 CIDR block associated with the VPC.')
ipv_6_cidr_ipv_6_pools = attribute("ipv_6_cidr_ipv_6_pools", default: '', description: 'The pool of a ipv6 CIDR block associated with the VPC.')


control 'aws-vpcs-1.0' do
  impact 1.0
  title 'Ensure AWS VPC CIDR Block plural resource has the correct properties.'
  describe aws_vpcs do
    its ('ipv_6_cidr_association_ids')  { should include ipv_6_cidr_association_ids }
    its ('ipv_6_cidr_states')           { should include "associated" }
    its ('ipv_6_cidr_status_messages')  { should be_empty }
    its ('ipv_6_cidr_network_border_groups')    { should include ipv_6_cidr_network_border_groups }
    its ('ipv_6_cidr_ipv_6_pools')  { should include ipv_6_cidr_ipv_6_pools }
  end
end
