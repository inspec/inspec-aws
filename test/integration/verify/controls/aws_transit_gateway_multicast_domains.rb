skip_control 'aws_transit_gateway_multicast_domains' do

  title 'Describes one or more transit gateway multicast domains.'
  describe aws_transit_gateway_multicast_domains do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_domains do
    its('transit_gateway_multicast_domain_ids') { should include 'tgw-mcast-domain-1234567890' }
    its('transit_gateway_ids') { should include 'tgw-1234567890' }
    its('transit_gateway_multicast_domain_arns') { should include 'tgw-1234567890' }
    its('owner_ids') { should include '1234567890' }
    its('states') { should include 'available' }
    its('tags') { should_not be_empty }
  end

  describe aws_transit_gateway_multicast_domains do
    its('options') { should_not be_empty }
  end
end
