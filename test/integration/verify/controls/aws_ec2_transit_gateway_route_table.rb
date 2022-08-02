transit_gateway_route_table_id = input(:transit_gateway_route_table_id, value: '', description: 'The ID of the transit gateway route table.')
transit_gateway_id = input(:transit_gateway_id, value: '', description: 'The ID of the transit gateway.')
state = 'active'
default_association_route_table = true
default_propagation_route_table = true

control 'aws-transit-gateway-route-tables-1.0' do
  impact 1.0
  title 'Describes one or more transit gateway route tables. By default, all transit gateway route tables are described. Alternatively, you can filter the results.'

  describe aws_ec2_transit_gateway_route_table(transit_gateway_route_table_id: transit_gateway_route_table_id) do
    it { should exist }
    its('transit_gateway_route_table_id') {should eq transit_gateway_route_table_id }
    its('transit_gateway_id') {should eq transit_gateway_id }
    its('state') {should eq state }
    its('default_association_route_table') {should eq default_association_route_table }
    its('default_propagation_route_table') {should eq default_propagation_route_table }
  end
end