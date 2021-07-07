control 'aws_transit_gateway_multicast_domain_associations' do
  impact 1.0
  title 'Gets information about the associations for the transit gateway multicast domain.'

  describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "") do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "") do
    its('transit_gateway_attachment_ids') { should include '' }
    its('resource_ids') { should include '' }
    its('resource_types') { should include 'vpc' }
    its('resource_owner_ids') { should include '' }
  end

  describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "") do
    its('subnets') { should_not be_empty }
  end
end