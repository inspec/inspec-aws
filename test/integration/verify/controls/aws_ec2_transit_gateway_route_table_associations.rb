aws_transit_gateway_attachment_id = input(:aws_transit_gateway_attachment_id_association, value: '', description: 'The IDs of the attachments.')
aws_resource_id = input(:aws_transit_gateway_attachment_vpc_id_association, value: '', description: 'The ID of the resource.')
aws_transit_gateway_route_table_id = input(:aws_transit_gateway_route_table_id_association, value: '', description: 'The ID of the route table for the transit gateway.')

control 'aws-ec2-transit-gateway-route-table-associations-1.0' do
  title 'Gets information about the associations for the specified transit gateway route table.'

  describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
    it { should exist }
    its('count') { should be <= 100 }
    its('transit_gateway_attachment_ids') { should include aws_transit_gateway_attachment_id }
    its('resource_ids') { should include aws_resource_id }
    its('resource_types') { should include 'vpc' }
    its('states') { should include 'associated' }
  end
end
