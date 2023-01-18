title 'Test single AWS VPC'

aws_default_vpc_id = input(:aws_default_vpc_id, value: '', description: 'The AWS region default VPC ID.')
aws_vpc_id = input(:aws_vpc_id, value: '', description: 'The AWS VPC ID.')
aws_vpc_cidr_block = input(:aws_vpc_cidr_block, value: '', description: 'The AWS VPC CIDR block.')
aws_vpc_instance_tenancy = input(:aws_vpc_instance_tenancy, value: '', description: 'The AWS VPC instance tenancy option.')
aws_vpc_dhcp_options_id = input(:aws_vpc_dhcp_options_id, value: '', description: 'The AWS VPC DHCP options ID.')
aws_vpc_name = input(:aws_vpc_name, value: '', description: 'The AWS VPC name.')

control 'aws-vpc-1.0' do
  title 'Ensure AWS VPC has the correct properties.'

  describe aws_vpc(vpc_id: aws_vpc_id) do
    it { should exist }
    its('cidr_block') { should eq aws_vpc_cidr_block }
    its ('instance_tenancy') { should eq aws_vpc_instance_tenancy }
    its ('vpc_id') { should eq aws_vpc_id }
    its ('state') { should eq 'available' }
    its ('dhcp_options_id') { should eq aws_vpc_dhcp_options_id }
    its ('tags') { should include('Name' => aws_vpc_name) }
    its ('associated_cidr_blocks') { should include(aws_vpc_cidr_block) }
    its('associated_ipv6_cidr_blocks') { should be_empty }
    it { should_not be_default }
    it { should be_available }
    it { should_not be_pending }
    it { should be_default_instance }
    it { should_not be_dedicated_instance }
    it { should_not be_host_instance }
    it { should have_cidr_block_associated(aws_vpc_cidr_block) }
    it { should_not have_cidr_block_association_failed(aws_vpc_cidr_block) }
    it { should_not has_cidr_block_disassociated(aws_vpc_cidr_block) }
  end

  describe aws_vpc(aws_vpc_id) do
    it { should exist }
    it { should_not be_default }
    its ('vpc_id') { should eq aws_vpc_id }
  end
end
