control 'aws-ec2-local-gateway-route-table-vpc-association-1.0' do
  impact 1.0
  title 'Describes the route table association of the local gateway.'

  describe aws_ec2_local_gateway_route_table_vpc_association(local_gateway_route_table_vpc_association_id: 'LocalGatewayRouteTableVpcAssociationId') do
    it { should exist }
  end

  describe aws_ec2_local_gateway_route_table_vpc_association(local_gateway_route_table_vpc_association_id: 'LocalGatewayRouteTableVpcAssociationId') do
    its("local_gateway_route_table_vpc_association_id") { should_not be_empty }
    its("local_gateway_route_table_id") { should_not be_empty }
    its("local_gateway_route_table_arn") { should_not be_empty }
    its("local_gateway_id") { should_not be_empty }
    its("vpc_id") { should_not be_empty }
    its("owner_id") { should_not be_empty }
    its("state") { should_not be_empty }
    its("tags") { should_not be_empty }
  end
end