control 'aws_transit_gateway_multicast_domains' do
  impact 1.0
  title 'Describes one or more transit gateway multicast domains.'
  describe aws_transit_gateway_multicast_domains do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_domains do
    its('transit_gateway_multicast_domain_ids') { should include '' }
    its('transit_gateway_ids') { should include '' }
    its('transit_gateway_multicast_domain_arns') { should include '' }
    its('owner_ids') { should include '' }
    its('states') { should include 'available' }
    its('tags') { should_not be_empty }
  end

  describe aws_transit_gateway_multicast_domains do
    its('options') { should_not be_empty }
  end
end
