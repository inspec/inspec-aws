title 'Test single AWS Transit Gateway Route '

transit_gateway_route_table_id = input(:aws_transit_gateway_route_table_id, value: '', description: 'The AWS Transit Gateway Route Table ID.')
cidr_block = input(:tgw_route_cidr_block, value: '', description: 'CIDR Block for the route')

control 'aws-transit-gateway-route-1.0' do
  impact 1.0
  title 'Ensure AWS Transit Gateway Route is configured correctly.'

  describe aws_transit_gateway_route(transit_gateway_route_table_id: transit_gateway_route_table_id, cidr_block: cidr_block) do
    it { should exist }
    it { should be_static }
    it { should be_vpc_attachment }
    it { should be_active }
    it { should_not be_blackhole }
  end
end
