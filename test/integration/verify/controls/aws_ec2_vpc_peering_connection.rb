control 'aws-ec2-vpc-peering-connection-1.0' do
  impact 1.0
  title 'Describes VPC Peering Connection of a particular vpc connection id.'

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'pcx-0a430aef71f9c2e3a') do
    it { should exist }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'pcx-0a430aef71f9c2e3a') do
    its ('accepter_vpc_info.cidr_block') { should eq '10.2.0.0/16' }
    its ('accepter_vpc_info.ipv_6_cidr_block_set') { should be_empty }
    its ('accepter_vpc_info.cidr_block_set') { should_not be_empty }
    its ('accepter_vpc_info.cidr_block_set.first.cidr_block') { should eq '10.2.0.0/16' }
    its ('accepter_vpc_info.owner_id') { should eq '112758395563' }
    its ('accepter_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc') { should eq false }
    its ('accepter_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc') { should eq false }
    its ('accepter_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link') { should eq false }
    its ('accepter_vpc_info.vpc_id') { should eq 'vpc-01bec355ffc7e59be' }
    its ('accepter_vpc_info.region') { should eq 'us-east-2' }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'pcx-0a430aef71f9c2e3a') do
    its ('expiration_time') { should eq nil }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'pcx-0a430aef71f9c2e3a') do
    its ('requester_vpc_info.cidr_block') { should eq '10.1.0.0/16' }
    its ('requester_vpc_info.ipv_6_cidr_block_set') { should be_empty }
    its ('requester_vpc_info.ipv_6_cidr_block_set.first.ipv_6_cidr_block') { should be_empty }
    its ('requester_vpc_info.cidr_block_set') { should_not be_empty }
    its ('requester_vpc_info.cidr_block_set.first.cidr_block') { should eq '10.1.0.0/16' }
    its ('requester_vpc_info.owner_id') { should eq '112758395563' }
    its ('requester_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc') { should eq false }
    its ('requester_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc') { should eq false }
    its ('requester_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link') { should eq false }
    its ('requester_vpc_info.vpc_id') { should eq 'vpc-05ac8a13d4fc2688f' }
    its ('requester_vpc_info.region') { should eq 'us-east-2' }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'pcx-0a430aef71f9c2e3a') do
    its ('status.code') { should eq 'active' }
    its ('status.message') { should eq 'Active' }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'pcx-0a430aef71f9c2e3a') do
    its ('tags') { should_not be_empty }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'pcx-0a430aef71f9c2e3a') do
    its ('vpc_peering_connection_id') { should eq 'pcx-0a430aef71f9c2e3a' }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'pcx-1234567890') do
    it { should_not exist }
  end
end