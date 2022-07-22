control 'aws_transit_gateway_multicast_group_source' do
  impact 1.0
  title 'Gets information about the associations for the transit gateway multicast domain.'

  describe aws_transit_gateway_multicast_group_source(transit_gateway_multicast_domain_id: '') do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_group_source(transit_gateway_multicast_domain_id: "") do
    its('group_ip_address') { should eq '224.0.0.1' }
    its('transit_gateway_attachment_id') { should eq '' }
    its('subnet_id') { should eq '' }
    its('resource_id') { should eq '' }
    its('resource_type') { should eq 'vpc' }
    its('resource_owner_id') { should eq '' }
    its('network_interface_id') { should eq '' }
    its('group_member') { should eq true }
    its('group_source') { should eq false }
    its('member_type') { should eq 'static' }
    its('source_type') { should be_empty }
  end
end
