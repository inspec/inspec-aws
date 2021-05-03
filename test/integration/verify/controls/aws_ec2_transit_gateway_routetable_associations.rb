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
  describe aws_ec2_transit_gateway_routetable_associations do
    it { should exist }
    its('transit_gateway_route_table_id') { should include aws_transit_gateway_route_table_id }
    its('state')                          { should include aws_associate_state }
  end
  describe aws_ec2_transit_gateway_attachments do
    it { should exist }
    its('transit_gateway_attachment_id')        { should eq aws_transit_gateway_attachment_id }
    its('resource_type')                        { should eq aws_resource_type }
    its('resource_id')                          { should eq aws_resource_id }
    its('state')                                { should eq aws_state }
    its('tags')                                 { should be_empty }
  end
end