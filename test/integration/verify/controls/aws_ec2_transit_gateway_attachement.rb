aws_transit_gateway_attachment_id = attribute(:aws_transit_gateway_attachment_id, default: '', description: 'The IDs of the attachments.')
aws_transit_gateway_id = attribute(:aws_transit_gateway_id, default: '', description: 'The ID of the transit gateway.')
aws_transit_gateway_owner_id = attribute(:aws_transit_gateway_owner_id, default: '', description: 'The ID of the AWS account that owns the transit gateway.')
aws_resource_owner_id = attribute(:aws_resource_owner_id, default: '', description: 'The ID of the AWS account that owns the resource.')
aws_resource_type = attribute(:aws_resource_type, default: '', description: 'The resource type. Valid values are vpc | vpn | direct-connect-gateway | peering | connect.')
aws_resource_id = attribute(:aws_resource_id, default: '', description: 'The ID of the resource.')
aws_state = attribute(:aws_state, default: '', description: 'The state of the attachment. Valid values are available | deleted | deleting | failed | failing | initiatingRequest | modifying | pendingAcceptance | pending | rollingBack | rejected | rejecting.')
aws_creation_time = attribute(:aws_creation_time, default: '', description: 'The creation time of the transit gateway.')
aws_association_transit_gateway_route_table_id = attribute(:aws_association_, default: '', description: 'The ID of the route table for the transit gateway.')
aws_association_state = attribute(:aws_association_, default: '', description: 'The state of the attachment. Valid values are | associating | associated | disassociating | disassociated |')

control 'aws-transit-gateway-attachment-v1.0.0' do
  impact 1.0
  title 'Describes one or more attachments between resources and transit gateways. By default, all attachments are described. Alternatively, you can filter the results by attachment ID, attachment state, resource ID, or resource owner.'
  describe aws_ec2_transit_gateway_attachement(transit_gateway_attachment_id: aws_transit_gateway_attachment_id) do
    it { should exist }
    its('transit_gateway_attachment_id')              { should eq aws_transit_gateway_attachment_id }
    its('transit_gateway_id')                         { should eq aws_transit_gateway_id }
    its('transit_gateway_owner_id')                   { should eq aws_transit_gateway_owner_id }
    its('resource_owner_id')                          { should eq aws_resource_owner_id }
    its('resource_type')                              { should eq aws_resource_type }
    its('resource_id')                                { should eq aws_resource_id }
    its('state')                                      { should eq aws_state }
    its('tags')                                       { should be_empty }
    its('association.transit_gateway_route_table_id') { should eq aws_association_transit_gateway_route_table_id }
    its('association.state')                          { should eq aws_association_state }
  end
end