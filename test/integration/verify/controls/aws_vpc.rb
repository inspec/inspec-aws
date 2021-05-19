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

aws_ipv_6_cidr_block_association_set_association_id = attribute("aws_ipv_6_cidr_block_association_set_association_id", default: '', description: 'The association ID for an IPv6 CIDR block associated with the VPC.')
aws_ipv_6_cidr_block_association_set_ipv_6_cidr_block = attribute("aws_ipv_6_cidr_block_association_set_ipv_6_cidr_block", default: '', description: 'An IPv4 CIDR block associated with the VPC.')
aws_ipv_6_cidr_block_association_set_network_border_group = attribute("aws_ipv_6_cidr_block_association_set_network_border_group", default: '', description: 'The name of the location from which we advertise the IPV6 CIDR block. Use this parameter to limit the CIDR block to this location.')
aws_ipv_6_cidr_block_association_set_ipv_6_pool = attribute("aws_ipv_6_cidr_block_association_set_ipv_6_pool", default: '', description: 'The ID of the IPv6 address pool from which the IPv6 CIDR block is allocated.')
aws_ipv_6_cidr_block_association_set_ipv_6_cidr_block_state_state = attribute("aws_ipv_6_cidr_block_association_set_ipv_6_cidr_block_state_state", default: '', description: 'The state of an IPv6 CIDR block associated with the VPC.')
aws_ipv_6_cidr_block_association_set_ipv_6_cidr_block_state_state_status_message = attribute("aws_ipv_6_cidr_block_association_set_ipv_6_cidr_block_state_state_status_message", default: '', description: 'The status message of an IPv6 CIDR block associated with the VPC.')

aws_cidr_block_association_set_association_id = attribute("aws_cidr_block_association_set_association_id", default: '', description: 'The association ID for a CIDR block associated with the VPC.')
aws_cidr_block_association_set_cidr_block = attribute("aws_cidr_block_association_set_cidr_block", default: '', description: 'A CIDR block associated with the VPC.')
aws_cidr_block_association_set_cidr_block_state_state = attribute("aws_cidr_block_association_set_cidr_block_state_state", default: '', description: 'The state of a CIDR block associated with the VPC.')
aws_cidr_block_association_set_cidr_block_state_status_message = attribute("aws_cidr_block_association_set_cidr_block_state_status_message", default: '', description: 'The status message of a CIDR block associated with the VPC.')

control 'aws-cidr-block-1.0' do
  impact 1.0
  title 'An CIDR block to associate with the VPC.'
  describe aws_vpc(vpc_id: aws_default_vpc_id) do
    its('cidr_block') { should eq aws_vpc_cidr_block }
  end
end

control 'aws-cidr-block-ipv-6-cidr-block-association-set-1.0' do
  impact 1.0
  title 'An IPv6 CIDR block to association set with the VPC.'
  describe aws_vpc(vpc_id: aws_default_vpc_id) do
    its ('ipv_6_cidr_block_association_set.first.association_id') { should eq aws_ipv_6_cidr_block_association_set_association_id }
    its ('ipv_6_cidr_block_association_set.first.ipv_6_cidr_block') { should eq aws_ipv_6_cidr_block_association_set_ipv_6_cidr_block }
    its ('ipv_6_cidr_block_association_set.first.network_border_group') { should eq aws_ipv_6_cidr_block_association_set_network_border_group }
    its ('ipv_6_cidr_block_association_set.first.ipv_6_pool') { should eq aws_ipv_6_cidr_block_association_set_ipv_6_pool }
    its ('ipv_6_cidr_block_association_set.first.ipv_6_cidr_block_state.state') { should eq aws_ipv_6_cidr_block_association_set_ipv_6_cidr_block_state_state }
    its ('ipv_6_cidr_block_association_set.first.ipv_6_cidr_block_state.status_message') { should be_empty }
  end
end

control 'aws-cidr-block-cidr-block-association-set-1.0' do
  impact 1.0
  title 'An CIDR block to association set with the VPC.'
  describe aws_vpc(vpc_id: aws_default_vpc_id) do
    its ('cidr_block_association_set.first.association_id') { should eq aws_cidr_block_association_set_association_id }
    its ('cidr_block_association_set.first.cidr_block') { should eq aws_cidr_block_association_set_cidr_block }
    its ('cidr_block_association_set.first.cidr_block_state.state') { should eq aws_cidr_block_association_set_cidr_block_state_state }
    its ('cidr_block_association_set.first.cidr_block_state.status_message') { should be_empty }
  end
end

control 'aws-cidr-block-1.0' do
  impact 1.0
  title 'An CIDR block to associate with the VPC.'
  describe aws_vpc(vpc_id: "vpc-00727fc4213acee4a") do
    it { should be_associated }
  end
end

control 'aws-cidr-block-1.0-associated-matcher' do
  impact 1.0
  title 'An CIDR block to associate with the VPC.'
  describe aws_vpc(vpc_id: aws_default_vpc_id) do
    it { should be_cidr_block_associated }
    it { should_not be_ipv_6_cidr_block_associated }
  end
end

