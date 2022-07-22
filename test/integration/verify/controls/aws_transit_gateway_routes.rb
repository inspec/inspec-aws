title 'Test multiple AWS Transit Gateway Routes '

transit_gateway_route_table_id = input(:aws_transit_gateway_route_table_id, value: '', description: 'The AWS Transit Gateway Route Table ID.')
cidr_block = input(:tgw_route_cidr_block, value: '', description: 'CIDR Block for the route')

control 'aws-transit-gateway-routes-1.0' do
  impact 1.0
  title 'Ensure AWS Transit Gateway Route is configured correctly.'

  describe aws_transit_gateway_routes(transit_gateway_route_table_id: transit_gateway_route_table_id).where(static: true) do
    it { should exist }
    its('cidr_blocks') { should include cidr_block }
  end

  describe aws_transit_gateway_routes(transit_gateway_route_table_id: transit_gateway_route_table_id, exact_match: cidr_block).where(static: true) do
    it { should exist }
    its('cidr_blocks') { should_not include '0.0.0.0/100' }
    its('states') { should include 'active' }
  end
end
