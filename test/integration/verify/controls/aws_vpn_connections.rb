title 'Test multiple AWS VPN Connection'

aws_vpn_connection_id = input(:aws_vpn_connection_id, value: '', description: 'The AWS VPN Connection ID.')
aws_vpn_gateway_id = input(:aws_vpn_gateway_id, value: '', description: 'The AWS VPN Gateway ID.')

control 'aws-vpn-connections-1.0' do
  impact 1.0
  desc 'Ensure AWS VPN Connections has the correct properties.'
  
  describe aws_vpn_connections do
    it { should exist }
  end
  
  describe aws_vpn_connections do
    its('states') { should include 'available' }
    its('types') { should include 'ipsec.1' }
    its('vpn_connection_ids') { should include aws_vpn_connection_id }
    its('vpn_gateway_ids') { should include aws_vpn_gateway_id }
    its('tags') { should_not be_empty }
  end
end
