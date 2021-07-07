control 'aws_transit_gateway_multicast_domain_association' do
  impact 1.0
  title 'Gets information about the associations for the transit gateway multicast domain.'

  describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: 'tgw-mcast-domain-0749b4c09fefa6551') do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: "tgw-mcast-domain-0749b4c09fefa6551") do
    its('transit_gateway_attachment_id') { should eq 'tgw-attach-03a924ff49189ecb2' }
    its('resource_id') { should eq 'vpc-07a4f94898fbdf788' }
    its('resource_type') { should eq 'vpc' }
    its('resource_owner_id') { should eq '112758395563' }
  end

  describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: "tgw-mcast-domain-0749b4c09fefa6551") do
    its('subnet.subnet_id') { should eq 'subnet-0748e5bf4fb241061' }
    its('subnet.state') { should eq 'associated' }
  end
end