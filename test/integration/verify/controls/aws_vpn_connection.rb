title 'Test single AWS VPN Connection'
aws_vpn_connection_id = attribute(:aws_vpn_connection_id, value: '', description: 'The AWS VPN Connection ID.')
aws_vpn_gateway_id = attribute(:aws_vpn_gateway_id, value: '', description: 'The AWS VPN Gateway ID.')

control 'aws-vpn-connection-1.0' do

  impact 1.0
  title 'Ensure AWS VPN Connection has the correct properties.'

  describe aws_vpn_connection(vpn_connection_id: aws_vpn_connection_id) do
    it { should exist }
    its('state') { should eq 'available' }
    its('type') { should eq 'ipsec.1' }
    its('vpn_gateway_id') { should eq aws_vpn_gateway_id }
    its('tags') { should eq('Name' => aws_vpn_gw_name) }
  end

  describe aws_vpn_connection(aws_vpn_connection_id) do
    it { should exist }
  end
end