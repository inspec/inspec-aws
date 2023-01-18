client_vpn_endpoint_id = input(:client_vpn_endpoint_id, value: '', description: '')

skip_control 'aws-ec2-client-vpn-endpoints-1.0' do
  title 'Test the properties of the vpn endpoints.'

  describe aws_ec2_client_vpn_endpoints do
    it { should exist }
    its('client_vpn_endpoint_ids') { should include client_vpn_endpoint_id }
    its('descriptions') { should include "Example Client VPN endpoint" }
    its('dns_names') { should_not include '*.cvpn-endpoint-1234567890.prod.clientvpn.us-east-2.amazonaws.com' }
    its('split_tunnels') { should include false }
    its('vpn_protocols') { should include 'openvpn' }
    its('transport_protocols') { should include 'udp' }
    its('vpn_ports') { should_not include 44365 }
    its('server_certificate_arns') { should_not include 'arn:aws:acm:us-east-2:1234567890:certificate/a20fe841-b1ef-4785-aefb-e69838eacdcb' }
  end
end
