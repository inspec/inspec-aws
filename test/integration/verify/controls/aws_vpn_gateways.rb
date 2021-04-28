title 'Test Collection of EC2 AWS VPN Gateway'

aws_vpn_gateway_id = attribute(:aws_vpn_gateway_id, default: '', description: 'The AWS VPN Gateway ID.')

control 'aws-ec2-dhcp-options-1.0' do

  impact 1.0
  title 'Ensure AWS EC2 DHCP Options has the correct properties.'
  describe aws_vpn_gateways do
    it { should exist }
    its('availability_zones') { should be_empty }
    its('states') { should include 'available' }
    its('types') { should include 'ipsec.1' }
    its('vpn_gateway_ids') { should include aws_vpn_gateway_id }
    its('amazon_side_asns') { should include 64512 }
    its('tags') { should include('Name' => 'random-name') }
    its('vpc_attachments') { should include(state: 'attached', vpc_id: 'vpc-0a510beed76210f2f') }
  end

  aws_vpn_gateways.each do |aws_vpn_gateway_id|
    describe aws_vpn_gateway(vpn_gateway_id: aws_vpn_gateway_id) do
      it { should exist }
      its('state') { should eq 'available' }
    end
  end
end
