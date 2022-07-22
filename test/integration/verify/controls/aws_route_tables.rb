title 'Test AWS Route Tables in bulk'

aws_vpc_id = input(:aws_vpc_id, value: '', description: 'The AWS VPC ID.')
aws_route_table_first_id = input(:aws_route_table_first_id, value: '', description: 'The AWS route table ID.')
aws_route_table_second_id = input(:aws_route_table_second_id, value: '', description: 'The AWS route table ID.')

control 'aws-route-tables-1.0' do
  impact 1.0
  title 'Ensure AWS Route Tables plural resource has the correct properties.'
  
  describe aws_route_tables do
    it { should exist }
    its('count') { should be >= 2 }
    its('vpc_ids') { should include aws_vpc_id }
    its('route_table_ids') { should include aws_route_table_first_id }
    its('route_table_ids') { should include aws_route_table_second_id }
  end
end

aws_carrier_gateway_id = input(:aws_carrier_gateway_id, value: '', description: 'The ID of the carrier gateway.')
aws_destination_cidr_block = input(:aws_destination_cidr_block, value: '', description: 'The IPv4 CIDR block used for the destination match.')
aws_destination_ipv_6_cidr_block = input(:aws_destination_ipv_6_cidr_block, value: '', description: 'The IPv6 CIDR block used for the destination match.')
aws_destination_prefix_list_id = input(:aws_destination_prefix_list_id, value: '', description: 'The prefix of the AWS service.')
aws_egress_only_internet_gateway_id = input(:aws_egress_only_internet_gateway_id, value: '', description: 'The ID of the egress-only internet gateway.')
aws_gateway_id = input(:aws_gateway_id, value: '', description: 'The ID of a gateway attached to your VPC.')
aws_instance_id = input(:aws_instance_id, value: '', description: 'The ID of a NAT instance in your VPC.')
aws_local_gateway_id = input(:aws_local_gateway_id, value: '', description: 'The ID of the local gateway.')
aws_nat_gateway_id = input(:aws_nat_gateway_id, value: '', description: 'The ID of a NAT gateway.')
aws_network_interface_id = input(:aws_network_interface_id, value: '', description: 'The ID of the network interface.')
aws_transit_gateway_id = input(:aws_transit_gateway_id, value: '', description: 'The ID of a transit gateway.')
aws_vpc_peering_connection_id = input(:aws_vpc_peering_connection_id, value: '', description: 'The ID of a VPC peering connection.')
aws_instance_owner_id = input(:aws_instance_owner_id, value: '', description: 'The owner ID of a NAT instance in your VPC.')
aws_origin = input(:aws_origin, value: '', description: 'Describes how the route was created.')
aws_state = input(:aws_state, value: '', description: 'The state of the route.')
aws_route_table_association_id = input(:aws_route_table_association_id, value: '', description: 'The ID of the AWS Route Table')
aws_route_table_associated_subnet = input(:aws_route_table_associated_subnet, value: '', description: 'The associated routed table subnet ID')


control 'aws-routes-1.0' do
  impact 1.0
  title 'Ensure AWS Route Tables plural resource has the correct properties.'
  
  describe aws_route_tables do
    it { should exist }
    its('count') { should be >= 2 }
    its('destination_cidr_blocks') { should include '10.0.0.0/27' }
    its ('destination_ipv_6_cidr_blocks') { should_not be_empty }
    its ('destination_prefix_list_ids') { should_not be_empty }
    its ('egress_only_internet_gateway_ids') { should be_empty }
    its ('gateway_ids') { should include 'local' }
    its ('instance_ids') { should be_empty }
    its ('instance_owner_ids') { should be_empty }
    its ('nat_gateway_ids') { should_not be_empty }
    its ('transit_gateway_ids') { should be_empty }
    its ('local_gateway_ids') { should be_empty }
    its ('carrier_gateway_ids') { should be_empty }
    its ('network_interface_ids') { should be_empty }
    its ('origins') { should include 'CreateRouteTable' }
    its ('states') { should include 'active' }
    its ('vpc_peering_connection_ids') { should be_empty }

    its('route_table_association_ids') { should include aws_route_table_association_id }
    its('association_subnet_ids') { should include aws_route_table_associated_subnet }
    its('associated_subnet_ids') { should include aws_route_table_associated_subnet }
    its('associated_gateway_ids') { should be_empty }
    its('association_gateway_ids') { should be_empty }
    its('association_states') { should include 'associated' }
  end
end
