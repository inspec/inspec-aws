aws_vpc_peering_connection_id = attribute(:aws_vpc_peering_connection_id, value: '')
aws_accepter_vpc_info_cidr_block = attribute(:aws_accepter_vpc_info_cidr_block, value: '')
aws_requester_vpc_info_cidr_block = attribute(:aws_requester_vpc_info_cidr_block, value: '')

control 'aws-ec2-vpc-peering-connection-1.0' do
  impact 1.0
  title 'Describes VPC Peering Connection of a particular vpc connection id.'

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: aws_vpc_peering_connection_id) do
    it { should exist }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: aws_vpc_peering_connection_id) do
    its ('accepter_vpc_info.cidr_block') { should eq aws_accepter_vpc_info_cidr_block }
    its ('accepter_vpc_info.ipv_6_cidr_block_set') { should be_empty }
    its ('accepter_vpc_info.cidr_block_set') { should_not be_empty }
    its ('accepter_vpc_info.cidr_block_set.first.cidr_block') { should eq aws_accepter_vpc_info_cidr_block }
    its ('accepter_vpc_info.owner_id') { should_not eq '1234567890' }
    its ('accepter_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc') { should eq false }
    its ('accepter_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc') { should eq false }
    its ('accepter_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link') { should eq false }
    its ('accepter_vpc_info.vpc_id') { should eq 'vpc-01bec355ffc7e59be' }
    its ('accepter_vpc_info.region') { should eq 'us-east-2' }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: aws_vpc_peering_connection_id) do
    its ('expiration_time') { should eq nil }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: aws_vpc_peering_connection_id) do
    its ('requester_vpc_info.cidr_block') { should eq aws_requester_vpc_info_cidr_block }
    its ('requester_vpc_info.ipv_6_cidr_block_set') { should be_empty }
    its ('requester_vpc_info.ipv_6_cidr_block_set.first.ipv_6_cidr_block') { should be_empty }
    its ('requester_vpc_info.cidr_block_set') { should_not be_empty }
    its ('requester_vpc_info.cidr_block_set.first.cidr_block') { should eq aws_requester_vpc_info_cidr_block }
    its ('requester_vpc_info.owner_id') { should_not eq '1234567890' }
    its ('requester_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc') { should eq false }
    its ('requester_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc') { should eq false }
    its ('requester_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link') { should eq false }
    its ('requester_vpc_info.vpc_id') { should_not eq 'dummy' }
    its ('requester_vpc_info.region') { should eq 'us-east-2' }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: aws_vpc_peering_connection_id) do
    its ('status.code') { should eq 'active' }
    its ('status.message') { should eq 'Active' }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: aws_vpc_peering_connection_id) do
    its ('tags') { should_not be_empty }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: aws_vpc_peering_connection_id) do
    its ('vpc_peering_connection_id') { should eq aws_vpc_peering_connection_id }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'pcx-1234567890') do
    it { should_not exist }
  end
end