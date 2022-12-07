aws_transit_gateway_attachment_id = input(:aws_transit_gateway_attachment_id_association, value: '', description: 'The IDs of the attachments.')
aws_resource_id = input(:aws_transit_gateway_attachment_vpc_id_association, value: '', description: 'The ID of the resource.')
aws_transit_gateway_route_table_id = input(:aws_transit_gateway_route_table_id_association, value: '', description: 'The ID of the route table for the transit gateway.')

control 'aws-ec2-transit-gateway-route-table-association-1.0' do
  impact 1.0
  title 'Gets information about the associations for the specified transit gateway route table.'

  describe aws_ec2_transit_gateway_route_table_association(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
    it { should exist }
    its('transit_gateway_attachment_id') { should eq aws_transit_gateway_attachment_id }
    its('resource_id')  { should eq aws_resource_id }
    its('resource_type')  { should eq 'vpc' }
    its('state') { should eq 'associated' }
  end
end