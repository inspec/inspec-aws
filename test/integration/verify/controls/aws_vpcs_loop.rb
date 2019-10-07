title 'Test AWS VPCs in bulk using plural and singular resources'

aws_vpc_id = attribute(:aws_vpc_id, default: '', description: 'The AWS VPC ID.')
aws_vpc_cidr_block = attribute(:aws_vpc_cidr_block, default: '', description: 'The AWS VPC CIDR block.')
aws_vpc_instance_tenancy = attribute(:aws_vpc_instance_tenancy, default: '', description: 'The AWS VPC instance tenancy option.')
aws_vpc_dhcp_options_id = attribute(:aws_vpc_dhcp_options_id, default: '', description: 'The AWS VPC DHCP options ID.')

control 'aws-vpcs-loop-1.0' do

  impact 1.0
  title 'Loop across AWS VPCs plural resource using singular resource for detail.'


  aws_vpcs.vpc_ids.each do |vpc|
    describe aws_vpc(vpc_id: vpc) do
      it { should exist }
      its('is_default') { should be_in [true, false] }
    end
  end

  aws_vpcs.where { vpc_id == aws_vpc_id }.vpc_ids.each do |vpc|
    describe aws_vpc(vpc_id: vpc) do
      it { should exist }
      its('cidr_block') { should eq aws_vpc_cidr_block }
      its ('instance_tenancy') { should eq aws_vpc_instance_tenancy }
      its ('vpc_id') { should eq aws_vpc_id }
      its ('state') { should eq 'available' }
      its ('dhcp_options_id') { should eq aws_vpc_dhcp_options_id }
      it { should_not be_default }
    end
  end
end