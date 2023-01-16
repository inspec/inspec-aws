title 'Test AWS VPCs in bulk using plural and singular resources'

aws_vpc_id = input(:aws_vpc_id, value: '', description: 'The AWS VPC ID.')
aws_vpc_cidr_block = input(:aws_vpc_cidr_block, value: '', description: 'The AWS VPC CIDR block.')
aws_vpc_instance_tenancy = input(:aws_vpc_instance_tenancy, value: '', description: 'The AWS VPC instance tenancy option.')
aws_vpc_dhcp_options_id = input(:aws_vpc_dhcp_options_id, value: '', description: 'The AWS VPC DHCP options ID.')

control 'aws-vpcs-loop-1.0' do
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
