control 'aws-ec2-vpn-connection-route-1.0' do
  impact 1.0
  title 'Specifies a static route for a VPN connection between an existing virtual private gateway and a VPN customer gateway.'

  describe aws_ec2_vpn_connection_route(vpn_connection_id: 'vpn-048a5007fdfa93270') do
    it { should exist }
  end

  describe aws_ec2_vpn_connection_route(vpn_connection_id: 'vpn-048a5007fdfa93270') do
    its ('destination_cidr_block') { should eq '192.168.10.0/24' }
    its ('source') { should be_empty }
    its ('state') { should eq 'available' }
  end

  describe aws_ec2_vpn_connection_route(vpn_connection_id: 'vpn-1234567890') do
    it { should_not exist }
  end
end