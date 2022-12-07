aws_vpc_peering_connection_id = input(:aws_vpc_peering_connection_id, value: '', description: '')
aws_vpc_peering_test1_id = input(:aws_vpc_peering_test1_id, value: '', description: '')
aws_vpc_peering_test2_id = input(:aws_vpc_peering_test2_id, value: '', description: '')

control 'aws-ec2-vpc-peering-connection-1.0' do
  impact 1.0
  title 'Test the properties of the aws ec2 vpc peer connection.'

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: aws_vpc_peering_connection_id) do
    it { should exist }
  end

  describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: aws_vpc_peering_connection_id) do
    its('accepter_vpc_info.cidr_block') { should be_empty }

    its('accepter_vpc_info.ipv_6_cidr_block_set') { should be_empty }
    its('accepter_vpc_info.cidr_block_set') { should be_empty }

    its('accepter_vpc_info.owner_id') { should_not eq '1234567890' }

    its('accepter_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc') { should be_empty  }
    its('accepter_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc') { should be_empty  }
    its('accepter_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link') { should be_empty  }
    its('accepter_vpc_info.vpc_id') { should eq aws_vpc_peering_test1_id }
    its('accepter_vpc_info.region') { should eq 'us-east-2' }

    its('expiration_time') { should be_empty }

    its('requester_vpc_info.ipv_6_cidr_block_set') { should be_empty }
    its('requester_vpc_info.cidr_block_set') { should be_empty }

    its('requester_vpc_info.owner_id') { should_not eq '1234567890' }

    its('requester_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc') { should be_empty  }
    its('requester_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc') { should be_empty  }
    its('requester_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link') { should be_empty  }
    its('requester_vpc_info.vpc_id') { should eq aws_vpc_peering_test2_id }
    its('requester_vpc_info.region') { should eq 'us-east-2' }

    its('status.code') { should eq 'deleted' }
    its('status.message') { should_not be_empty }

    its('tags') { should be_empty }
    its('vpc_peering_connection_id') { should eq aws_vpc_peering_connection_id }
  end
end