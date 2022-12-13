control 'aws_transit_gateway_multicast_group_sources' do
  title 'Gets information about the associations for the transit gateway multicast domain.'

  describe aws_transit_gateway_multicast_group_sources(transit_gateway_multicast_domain_id: "") do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_group_sources(transit_gateway_multicast_domain_id: "") do
    its('group_ip_addresses') { should include '224.0.0.1' }
    its('transit_gateway_attachment_ids') { should include '' }
    its('subnet_ids') { should include '' }
    its('resource_ids') { should include '' }
    its('resource_types') { should include 'vpc' }
    its('resource_owner_ids') { should include '' }
    its('network_interface_ids') { should include '' }
    its('group_members') { should include true }
    its('group_sources') { should include false }
    its('member_types') { should include 'static' }
    its('source_types') { should_not be_empty }
  end

  describe aws_transit_gateway_multicast_group_sources(transit_gateway_multicast_domain_id: 'dummy') do
    it { should_not exist }
  end
end
