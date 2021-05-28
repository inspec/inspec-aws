title 'Test AWS Route Tables in bulk'

aws_vpc_id = attribute(:aws_vpc_id, default: '', description: 'The AWS VPC ID.')
aws_route_table_first_id = attribute(:aws_route_table_first_id, default: '', description: 'The AWS route table ID.')
aws_route_table_second_id = attribute(:aws_route_table_second_id, default: '', description: 'The AWS route table ID.')

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

title 'Test multiple AWS Route'
aws_carrier_gateway_id = attribute("aws_carrier_gateway_id", default: "", description: "The ID of the carrier gateway.")
aws_destination_cidr_block = attribute("aws_destination_cidr_block", default: "", description: "The IPv4 CIDR block used for the destination match.")
aws_destination_ipv_6_cidr_block = attribute("aws_destination_ipv_6_cidr_block", default: "", description: "The IPv6 CIDR block used for the destination match.")
aws_destination_prefix_list_id = attribute("aws_destination_prefix_list_id", default: "", description: "The prefix of the AWS service.")
aws_egress_only_internet_gateway_id = attribute("aws_egress_only_internet_gateway_id", default: "", description: "The ID of the egress-only internet gateway.")
aws_gateway_id = attribute("aws_gateway_id", default: "", description: "The ID of a gateway attached to your VPC.")
aws_instance_id = attribute("aws_instance_id", default: "", description: "The ID of a NAT instance in your VPC.")
aws_local_gateway_id = attribute("aws_local_gateway_id", default: "", description: "The ID of the local gateway.")
aws_nat_gateway_id = attribute("aws_nat_gateway_id", default: "", description: "The ID of a NAT gateway.")
aws_network_interface_id = attribute("aws_network_interface_id", default: "", description: "The ID of the network interface.")
aws_transit_gateway_id = attribute("aws_transit_gateway_id", default: "", description: "The ID of a transit gateway.")
aws_vpc_peering_connection_id = attribute("aws_vpc_peering_connection_id", default: "", description: "The ID of a VPC peering connection.")
aws_instance_owner_id = attribute("aws_instance_owner_id", default: "", description: "The owner ID of a NAT instance in your VPC.")
aws_origin = attribute("aws_origin", default: "", description: "Describes how the route was created.")
aws_state = attribute("aws_state", default: "", description: "The state of the route.")

control 'aws-routes-1.0' do
  impact 1.0
  title 'Ensure AWS Route Tables plural resource has the correct properties.'
  describe aws_route_tables do
    it { should exist }
    its('count') { should be >= 2 }
    its('destination_cidr_blocks') { should include "10.0.0.0/27" }
    its ('destination_ipv_6_cidr_blocks') { should_not be_empty }
    its ('destination_prefix_list_ids') { should_not be_empty }
    its ('egress_only_internet_gateway_ids') { should be_empty }
    its ('gateway_ids') { should include "local" }
    its ('instance_ids') { should be_empty }
    its ('instance_owner_ids') { should be_empty }
    its ('nat_gateway_ids') { should_not be_empty }
    its ('transit_gateway_ids') { should be_empty }
    its ('local_gateway_ids') { should be_empty }
    its ('carrier_gateway_ids') { should be_empty }
    its ('network_interface_ids') { should be_empty }
    its ('origins') { should include "CreateRouteTable" }
    its ('states') { should include "active" }
    its ('vpc_peering_connection_ids') { should be_empty }
  end
end