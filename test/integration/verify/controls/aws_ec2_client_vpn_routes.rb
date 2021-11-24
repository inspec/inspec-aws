# frozen_string_literal: true
client_vpn_endpoint_id = attribute('client_vpn_endpoint_id', value: '', description: '')
target_subnet = attribute('target_subnet', value: '', description: '')
control 'aws_ec2_client_vpn_routes-1.0' do
  impact 1.0
  title 'Test the properties of the vpn routes.'
  describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: 'cvpn-endpoint-08720d356dd9928c8') do
    it { should exist }
    its('origins') { should include 'associate' }
    its('destination_cidr') { should include '172.31.0.0/16' }
    its('target_subnets') { should include target_subnet }
    its('client_vpn_endpoint_ids') { should include client_vpn_endpoint_id }
    its('status_codes') { should include 'active' }
    its('status_messages') { should include nil }
    its('types') { should include 'Nat' }
  end
end