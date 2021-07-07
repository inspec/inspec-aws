control 'aws_transit_gateway_multicast_group_member' do
  impact 1.0
  title 'Gets information about the associations for the transit gateway multicast domain.'

  describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: 'tgw-mcast-domain-0749b4c09fefa6551') do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "tgw-mcast-domain-0749b4c09fefa6551") do
    its('group_ip_address') { should eq '224.0.0.1' }
    its('transit_gateway_attachment_id') { should eq 'tgw-attach-03a924ff49189ecb2' }
    its('subnet_id') { should eq 'subnet-0748e5bf4fb241061' }
    its('resource_id') { should eq 'vpc-07a4f94898fbdf788' }
    its('resource_type') { should eq 'vpc' }
    its('resource_owner_id') { should eq '112758395563' }
    its('network_interface_id') { should eq 'eni-04d95ad1f735659bf' }
    its('group_member') { should eq true }
    its('group_source') { should eq false }
    its('member_type') { should eq 'static' }
    its('source_type') { should be_empty }
  end
end