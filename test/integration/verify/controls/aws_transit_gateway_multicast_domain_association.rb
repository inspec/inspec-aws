skip_control 'aws_transit_gateway_multicast_domain_association' do

  title 'Gets information about the associations for the transit gateway multicast domain.'

  describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: 'tgw-mcast-domain-1234567890') do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
    its('transit_gateway_attachment_id') { should eq 'tgw-attach-1234567890' }
    its('resource_id') { should eq 'vpc-1234567890' }
    its('resource_type') { should eq 'vpc' }
    its('resource_owner_id') { should eq '1234567890' }
  end

  describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
    its('subnet.subnet_id') { should eq '' }
    its('subnet.state') { should eq 'associated' }
  end
end
