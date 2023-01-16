skip_control 'aws_transit_gateway_multicast_domain' do

  title 'Describes one or more transit gateway multicast domains.'
  describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
    its('transit_gateway_multicast_domain_id') { should eq 'tgw-mcast-domain-1234567890' }
    its('transit_gateway_id') { should eq 'tgw-1234567890' }
    its('transit_gateway_multicast_domain_arn') { should eq 'tgw-1234567890' }
    its('owner_id') { should eq '1234567890' }
    its('state') { should eq 'available' }
    its('tags') { should_not be_empty }
  end

  describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
    its('options.igmpv_2_support') { should eq 'disable' }
    its('options.static_sources_support') { should eq 'enable' }
    its('options.auto_accept_shared_associations') { should eq 'enable' }
  end
end
