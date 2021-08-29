control 'aws-ec2-local-gateway-route-table-vpc-associations-1.0' do
  impact 1.0
  title 'Describes the route table associations of the local gateway.'

  describe aws_ec2_local_gateway_route_table_vpc_associations do
    it { should exist }
  end

  describe aws_ec2_local_gateway_route_table_vpc_associations do
    its("local_gateway_route_table_vpc_association_ids") { should_not be_empty }
    its("local_gateway_route_table_ids") { should_not be_empty }
    its("local_gateway_route_table_arns") { should_not be_empty }
    its("local_gateway_ids") { should_not be_empty }
    its("vpc_ids") { should_not be_empty }
    its("owner_ids") { should_not be_empty }
    its("states") { should_not be_empty }
    its("tags") { should_not be_empty }
  end
end