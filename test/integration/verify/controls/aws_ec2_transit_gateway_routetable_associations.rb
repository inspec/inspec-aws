aws_transit_gateway_attachment_id = attribute(:aws_transit_gateway_attachment_id, default: '', description: 'The IDs of the attachments.')
aws_resource_type = attribute(:aws_resource_type, default: '', description: 'The resource type. Valid values are vpc | vpn | direct-connect-gateway | peering | connect.')
aws_resource_id = attribute(:aws_resource_id, default: '', description: 'The ID of the resource.')
aws_associate_state = attribute(:aws_associate_state, default: '', description: 'The state of the attachment. Valid values are available | deleted | deleting | failed | failing | initiatingRequest | modifying | pendingAcceptance | pending | rollingBack | rejected | rejecting.')
aws_transit_gateway_route_table_id = attribute(:aws_transit_gateway_route_table_id, default: '', description: 'The ID of the route table for the transit gateway.')
aws_resource_type = attribute(:aws_resource_type, default: '', description: 'The resource type. Valid values are vpc | vpn | direct-connect-gateway | peering | connect.')
aws_resource_id = attribute(:aws_resource_id, default: '', description: 'The ID of the resource.')
aws_state = attribute(:aws_state, default: '', description: 'The state of the attachment. Valid values are available | deleted | deleting | failed | failing | initiatingRequest | modifying | pendingAcceptance | pending | rollingBack | rejected | rejecting.')

control 'aws-rc2-transit-gateway-routetable-associations-v1.0.0' do
  impact 1.0
  title 'Gets information about the associations for the specified transit gateway route table.'
  describe aws_ec2_transit_gateway_routetable_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
    it { should exist }
    its('count') { should be <= 100 }
    its('transit_gateway_attachment_ids') { should include aws_transit_gateway_attachment_id }
    its('resource_ids') { should include aws_resource_id }
    its('resource_types') { should include aws_resource_type }
    its('transit_gateway_attachment_ids') { should include aws_transit_gateway_attachment_id }
    its('states') { should include aws_associate_state }
  end
end