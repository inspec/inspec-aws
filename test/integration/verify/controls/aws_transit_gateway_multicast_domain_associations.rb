skip_control 'aws_transit_gateway_multicast_domain_associations' do

  title 'Gets information about the associations for the transit gateway multicast domain.'

  describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
    its('transit_gateway_attachment_ids') { should include 'tgw-attach-1234567890' }
    its('resource_ids') { should include 'vpc-1234567890' }
    its('resource_types') { should include 'vpc' }
    its('resource_owner_ids') { should include '1234567890' }
  end

  describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
    its('subnets') { should_not be_empty }
  end
end
