title 'Test single AWS Route Table'

aws_vpc_id = input(:aws_vpc_id, value: '', description: 'The AWS VPC ID.')
aws_route_table_first_id = input(:aws_route_table_first_id, value: '', description: 'The AWS route table ID.')
aws_route_table_second_id = input(:aws_route_table_second_id, value: '', description: 'The AWS route table ID.')

control 'aws-route-table-1.0' do
  impact 1.0
  title 'Ensure AWS AWS Route Table has the correct properties.'
  
  describe aws_route_table(route_table_id: aws_route_table_first_id) do
    it { should exist }
    its ('vpc_id') { should eq aws_vpc_id }
  end
  describe aws_route_table(aws_route_table_first_id) do
    it { should exist }
    its ('vpc_id') { should eq aws_vpc_id }
  end
  describe aws_route_table(aws_route_table_second_id) do
    it { should exist }
    its ('vpc_id') { should eq aws_vpc_id }
  end
  describe aws_route_table('rtb-1234abcd') do
    it { should_not exist }
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

control 'aws-route-1.0' do
  impact 1.0
  title 'Ensure AWS AWS Route has the correct properties.'
  
  describe aws_route_table(route_table_id: 'rtb-0801bea66842eac41') do
    its('route_table_id') { should cmp 'rtb-0801bea66842eac41' }
    it { should exist }
    its ('routes.first.destination_cidr_block') { should eq aws_destination_cidr_block }
    its ('routes.first.destination_ipv_6_cidr_block') { should be_empty }
    its ('routes.first.destination_prefix_list_id') { should be_empty }
    its ('routes.first.egress_only_internet_gateway_id') { should be_empty }
    its ('routes.first.gateway_id') { should eq aws_gateway_id }
    its ('routes.first.instance_id') { should be_empty }
    its ('routes.first.instance_owner_id') { should be_empty }
    its ('routes.first.nat_gateway_id') { should be_empty }
    its ('routes.first.transit_gateway_id') { should be_empty }
    its ('routes.first.local_gateway_id') { should be_empty }
    its ('routes.first.carrier_gateway_id') { should be_empty }
    its ('routes.first.network_interface_id') { should be_empty }
    its ('routes.first.origin') { should eq aws_origin }
    its ('routes.first.state') { should eq aws_state }
    its ('routes.first.vpc_peering_connection_id') { should be_empty }

    its('associated_subnet_ids') { should include aws_route_table_associated_subnet }
    its('associated_gateway_ids') { should be_empty }
    it { should_not be_main }
    it { should have_subnet_associated(aws_route_table_associated_subnet) }
    it { should_not have_failed_association_value(aws_route_table_associated_subnet) }
    it { should_not have_failed_association_value }
  end
end
