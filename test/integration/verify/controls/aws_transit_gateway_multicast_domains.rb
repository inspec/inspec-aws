control 'aws_transit_gateway_multicast_domains' do
  impact 1.0
  title 'Describes one or more transit gateway multicast domains.'
  describe aws_transit_gateway_multicast_domains do
    it { should exist }
  end

  describe aws_transit_gateway_multicast_domains do
    its('transit_gateway_multicast_domain_ids') { should include 'tgw-mcast-domain-0814d49959a72bcd5' }
    its('transit_gateway_ids') { should include 'tgw-0e995e1955e41d44b' }
    its('transit_gateway_multicast_domain_arns') { should include 'arn:aws:ec2:us-east-2:112758395563:transit-gateway-multicast-domain/tgw-mcast-domain-0814d49959a72bcd5' }
    its('owner_ids') { should include '112758395563' }
    its('states') { should include 'available' }
    # its('creation_times') { should_not be_empty }
    its('tags') { should_not be_empty }
  end

  describe aws_transit_gateway_multicast_domains do
    its('options') { should_not be_empty }
  end
end
