title 'Test AWS VPCs in bulk'

aws_vpc_id = attribute(:aws_vpc_id, default: '', description: 'The AWS VPC ID.')
aws_vpc_cidr_block = attribute(:aws_vpc_cidr_block, default: '', description: 'The AWS VPC CIDR block.')
aws_vpc_instance_tenancy = attribute(:aws_vpc_instance_tenancy, default: '', description: 'The AWS VPC instance tenancy option.')
aws_vpc_dhcp_options_id = attribute(:aws_vpc_dhcp_options_id, default: '', description: 'The AWS VPC DHCP options ID.')

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
    its('tags')              { should include('Name' => 'inspec-aws-vpc') }
  end

end