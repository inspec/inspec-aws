title 'Test AWS VPC Subnets in bulk using plural and singular resources'

aws_subnet_id = attribute(:aws_subnet_id, default: '', description: 'The AWS VPC Subnet ID.')
aws_subnet_cidr_block = attribute(:aws_subnet_cidr_block, default: '', description: 'The AWS VPC Subnet CIDR block.')
aws_subnet_ip_address_count = attribute(:aws_subnet_ip_address_count, default: '', description: 'The AWS VPC Subnet IP address count.')
aws_vpc_id = attribute(:aws_vpc_id, default: '', description: 'The AWS VPC ID.')
aws_availability_zone = attribute(:aws_availability_zone, default: '', description: 'The AWS AZ.')

control 'aws-subnets-loop-1.0' do

  impact 1.0
  title 'Loop across AWS VPC Subnets plural resource using singular resource for detail.'


  aws_subnets.subnet_ids.each do |subnet|
    describe aws_subnet(subnet_id: subnet) do
      it { should exist }
    end
  end

  aws_subnets.where { vpc_id == aws_vpc_id }.subnet_ids.each do |subnet|
    describe aws_subnet(subnet_id: subnet) do
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
  end
end