control 'aws_transit_gateway_multicast_domain' do
  impact 1.0
  title 'Describes one or more transit gateway multicast domains.'
  describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: "tgw-mcast-domain-0814d49959a72bcd5") do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: "tgw-mcast-domain-0814d49959a72bcd5") do
    its('transit_gateway_multicast_domain_id') { should eq 'tgw-mcast-domain-0814d49959a72bcd5' }
    its('transit_gateway_id') { should eq 'tgw-0e995e1955e41d44b' }
    its('transit_gateway_multicast_domain_arn') { should eq 'arn:aws:ec2:us-east-2:112758395563:transit-gateway-multicast-domain/tgw-mcast-domain-0814d49959a72bcd5' }
    its('owner_id') { should eq '112758395563' }
    its('state') { should eq 'available' }
    its('tags') { should_not be_empty }
  end

  describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: "tgw-mcast-domain-0814d49959a72bcd5") do
    its('options.igmpv_2_support') { should eq 'disable' }
    its('options.static_sources_support') { should eq 'enable' }
    its('options.auto_accept_shared_associations') { should eq 'enable' }
  end
end