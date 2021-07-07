control 'aws_transit_gateway_multicast_domain_associations' do
  impact 1.0
  title 'Gets information about the associations for the transit gateway multicast domain.'

  describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "tgw-mcast-domain-0749b4c09fefa6551") do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "tgw-mcast-domain-0749b4c09fefa6551") do
    its('transit_gateway_attachment_ids') { should include 'tgw-attach-03a924ff49189ecb2' }
    its('resource_ids') { should include 'vpc-07a4f94898fbdf788' }
    its('resource_types') { should include 'vpc' }
    its('resource_owner_ids') { should include '112758395563' }
  end

  describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "tgw-mcast-domain-0749b4c09fefa6551") do
    its('subnets') { should_not be_empty }
  end
end