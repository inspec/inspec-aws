aws_transit_gateway_attachment_id = input(:aws_transit_gateway_attachment_id1, value: '', description: 'The IDs of the attachments.')
aws_transit_gateway_id = input(:aws_transit_gateway_id, value: '', description: 'The ID of the transit gateway.')
aws_transit_gateway_owner_id = input(:aws_transit_gateway_owner_id, value: '', description: 'The ID of the AWS account that owns the transit gateway.')

control 'aws-transit-gateway-attachment-1.0' do
  title 'Describes one or more attachments between resources and transit gateways. By default, all attachments are described. Alternatively, you can filter the results by attachment ID, attachment state, resource ID, or resource owner.'

  describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: aws_transit_gateway_attachment_id) do
    it { should exist }
    its('transit_gateway_attachment_id')              { should eq aws_transit_gateway_attachment_id }
    its('transit_gateway_id')                         { should eq aws_transit_gateway_id }
    its('transit_gateway_owner_id')                   { should eq aws_transit_gateway_owner_id }
    its('resource_owner_id')                          { should_not be_empty }
    its('resource_type')                              { should_not be_empty }
    its('resource_id')                                { should_not be_empty }
    its('state')                                      { should eq 'available' }
    its('tags')                                       { should be_empty }
    its('association.state')                          { should eq 'associated' }
  end
end
