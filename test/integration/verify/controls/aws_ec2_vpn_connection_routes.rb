aws_vpn_connection_id = input(:aws_vpn_connection_id, value: '', description: '')

control 'aws-ec2_vpn-connection-routes-1.0' do
  impact 1.0
  title 'Test the properties of the aws ec2 VPN connection routes.'

  describe aws_ec2_vpn_connection_routes(vpn_connection_id: aws_vpn_connection_id) do
    it { should exist }
  end

  describe aws_ec2_vpn_connection_routes(vpn_connection_id: aws_vpn_connection_id) do
    its('destination_cidr_blocks') { should include [['192.168.10.0/24']] }
    its('sources') { should_not be_empty }
    its('states') { should include [['available']] }
  end
end
