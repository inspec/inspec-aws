title 'Test single AWS VPC Subnet'

aws_subnet_id = attribute(:aws_subnet_id, default: '', description: 'The AWS VPC Subnet ID.')
aws_subnet_cidr_block = attribute(:aws_subnet_cidr_block, default: '', description: 'The AWS VPC Subnet CIDR block.')
aws_subnet_ip_address_count = attribute(:aws_subnet_ip_address_count, default: '', description: 'The AWS VPC Subnet IP address count.')
aws_vpc_id = attribute(:aws_vpc_id, default: '', description: 'The AWS VPC ID.')
aws_availability_zone = attribute(:aws_availability_zone, default: '', description: 'The AWS AZ.')

control 'aws-subnet-1.0' do

  impact 1.0
  title 'Ensure AWS VPC Subnet has the correct properties.'

  describe aws_subnet(subnet_id: aws_subnet_id) do
    it { should exist }
    its('vpc_id') { should eq aws_vpc_id }
    its('subnet_id') { should eq aws_subnet_id }
    its('cidr_block') { should eq aws_subnet_cidr_block }
    its('available_ip_address_count') { should eq aws_subnet_ip_address_count - 5 } # AWS Reserve 5
    its('availability_zone') { should eq aws_availability_zone }
    its('ipv_6_cidr_block_association_set') { should eq [] }
    it { should be_available }
    it { should_not be_mapping_public_ip_on_launch }
    it { should_not be_default_for_az }
    it { should_not be_assigning_ipv_6_address_on_creation }
  end

  # Test hash given subnet_id
  describe aws_subnet(subnet_id: aws_subnet_id) do
    it { should exist }
  end

  # Test scalar works
  describe aws_subnet(aws_subnet_id) do
    it { should exist }
  end

  describe aws_subnet(subnet_id: 'subnet-00000000') do
    it { should_not exist }
  end

end