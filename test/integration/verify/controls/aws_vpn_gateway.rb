title 'Test single AWS VPN Gateway'
aws_vpn_gateway_id = attribute(:aws_vpn_gateway_id, default: '', description: 'The AWS VPN Gateway ID.')

control 'aws-vpn-gateway-1.0' do

  impact 1.0
  title 'Ensure AWS VPN Gateway has the correct properties.'

  describe aws_vpn_gateway(vpn_gateway_id: aws_vpn_gateway_id) do
    it { should exist }
    its('availability_zone') { should be_nil }
    its('state') { should eq 'available' }
    its('type') { should eq 'ipsec.1' }
    its('vpn_gateway_id') { should eq 'vgw-014aef8a0689b8f43' }
    its('amazon_side_asn') { should eq 64512 }
    its('tags') { should eq('Name' => 'random-name') }
    its('attached?') { should be_truthy }
    its('vpc_id') { should eq 'vpc-0a510beed76210f2f' }
  end

  describe aws_vpn_gateway(aws_vpn_gateway_id) do
    it { should exist }
  end
end
