transit_gateway_route_table_id = input(:transit_gateway_route_table_id, value: '', description: 'The ID of the transit gateway route table.')
aws_transit_gateway_attachment_id = input(:aws_transit_gateway_attachment_id1, value: '', description: 'The IDs of the attachments.')

control 'aws-ec2-transit-gateway-route-table-propagations-1.0' do
  title 'Lists information about the route table propagations for the specified transit gateway route table.'

  describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: transit_gateway_route_table_id) do
    it { should exist }
  end

  describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: transit_gateway_route_table_id) do
    its ('transit_gateway_attachment_ids') { should include aws_transit_gateway_attachment_id}
    its ('resource_ids') { should_not include 'vpc-1234567890'}
    its ('resource_types') { should include 'vpc'}
    its ('states') { should include 'enabled'}
  end
end
