title 'Test single AWS VPC'

aws_default_vpc_id = attribute(:aws_default_vpc_id, default: '', description: 'The AWS region default VPC ID.')
aws_vpc_id = attribute(:aws_vpc_id, default: '', description: 'The AWS VPC ID.')
aws_vpc_cidr_block = attribute(:aws_vpc_cidr_block, default: '', description: 'The AWS VPC CIDR block.')
aws_vpc_instance_tenancy = attribute(:aws_vpc_instance_tenancy, default: '', description: 'The AWS VPC instance tenancy option.')
aws_vpc_dhcp_options_id = attribute(:aws_vpc_dhcp_options_id, default: '', description: 'The AWS VPC DHCP options ID.')
aws_vpc_name = attribute(:aws_vpc_name, default: '', description: 'The AWS VPC name.')

control 'aws-vpc-1.0' do

  impact 1.0
  title 'Ensure AWS VPC has the correct properties.'

  describe aws_vpc(vpc_id: aws_vpc_id) do
    it { should exist }
    its('cidr_block') { should eq aws_vpc_cidr_block }
    its ('instance_tenancy') { should eq aws_vpc_instance_tenancy }
    its ('vpc_id') { should eq aws_vpc_id }
    its ('state') { should eq 'available' }
    its ('dhcp_options_id') { should eq aws_vpc_dhcp_options_id }
    its ('tags') { should include('Name' => aws_vpc_name)}
    it { should_not be_default }
  end

  describe aws_vpc do
    it { should exist }
    it { should be_default }
    it { should be_available }
    its ('vpc_id') { should eq aws_default_vpc_id }
  end

  describe aws_vpc(aws_vpc_id) do
    it { should exist }
    it { should_not be_default }
    its ('vpc_id') { should eq aws_vpc_id }
  end

end