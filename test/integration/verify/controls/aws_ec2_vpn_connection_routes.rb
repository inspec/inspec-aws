control 'aws-ec2-vpn-connection-routes-1.0' do
  impact 1.0
  title 'Lists a static route for a VPN connection between an existing virtual private gateway and a VPN customer gateway.'

  describe aws_ec2_vpn_connection_routes(vpn_connection_id: 'vpn-048a5007fdfa93270') do
    it { should exist }
  end

  describe aws_ec2_vpn_connection_routes(vpn_connection_id: 'vpn-048a5007fdfa93270') do
    its ('destination_cidr_blocks') { should include '192.168.10.0/24' }
    its ('sources') { should_not be_empty }
    its ('states') { should include 'available' }
  end

  describe aws_ec2_vpn_connection_routes(vpn_connection_id: 'vpn-1234567890') do
    it { should_not exist }
  end
end