title 'Test single AWS VPN Connection'

aws_vpn_connection_id = input(:aws_vpn_connection_id, value: '', description: 'The AWS VPN Connection ID.')
aws_vpn_gateway_id = input(:aws_vpn_gateway_id, value: '', description: 'The AWS VPN Gateway ID.')
aws_vpn_customer_gateway_id = input(:aws_vpn_customer_gateway_id, value: '', description: 'The AWS VPN Customer Gateway ID.')

control 'aws-vpn-connection-1.0' do
  impact 1.0
  title 'Ensure AWS VPN Connection has the correct properties.'
  
  describe aws_vpn_connection(aws_vpn_connection_id) do
    it { should exist }
  end
  
  describe aws_vpn_connection(vpn_connection_id: aws_vpn_connection_id) do
    it { should exist }
    
    its('customer_gateway_configuration') { should_not be_empty }
    its('customer_gateway_id') { should eq aws_vpn_customer_gateway_id }
    its('category') { should eq 'VPN' }
    its('state') { should eq 'available' }
    its('type') { should eq 'ipsec.1' }
    its('vpn_connection_id') { should eq aws_vpn_connection_id }
    its('vpn_gateway_id') { should eq aws_vpn_gateway_id }
    its('transit_gateway_id') { should be_empty }
    its('core_network_arn') { should be_empty }
    its('core_network_attachment_arn') { should be_empty }
    its('gateway_association_state') { should eq 'associated' }
    its('tags') { should be_empty }
  end
end
