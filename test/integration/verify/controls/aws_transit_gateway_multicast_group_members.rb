control 'aws_transit_gateway_multicast_group_members' do
  impact 1.0
  title 'Gets information about the associations for the transit gateway multicast domain.'

  describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "tgw-mcast-domain-0749b4c09fefa6551") do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "tgw-mcast-domain-0749b4c09fefa6551") do
    its('group_ip_addresses') { should include '224.0.0.1' }
    its('transit_gateway_attachment_ids') { should include 'tgw-attach-03a924ff49189ecb2' }
    its('subnet_ids') { should include 'subnet-0748e5bf4fb241061' }
    its('resource_ids') { should include 'vpc-07a4f94898fbdf788' }
    its('resource_types') { should include 'vpc' }
    its('resource_owner_ids') { should include '112758395563' }
    its('network_interface_ids') { should include 'eni-04d95ad1f735659bf' }
    its('group_members') { should include true }
    its('group_sources') { should include false }
    its('member_types') { should include 'static' }
    its('source_types') { should_not be_empty }
  end

  describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: 'dummy') do
    it { should_not exist }
  end
end