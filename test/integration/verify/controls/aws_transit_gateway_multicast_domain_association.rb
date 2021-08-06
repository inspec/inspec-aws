skip_control 'aws_transit_gateway_multicast_domain_association' do
  impact 1.0
  title 'Gets information about the associations for the transit gateway multicast domain.'

  describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: '') do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: "t") do
    its('transit_gateway_attachment_id') { should eq '' }
    its('resource_id') { should eq '' }
    its('resource_type') { should eq 'vpc' }
    its('resource_owner_id') { should eq '' }
  end

  describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: "") do
    its('subnet.subnet_id') { should eq '' }
    its('subnet.state') { should eq 'associated' }
  end
end