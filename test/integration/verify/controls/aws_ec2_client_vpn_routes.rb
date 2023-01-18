client_vpn_endpoint_id = input(:client_vpn_endpoint_id, value: '', description: '')
target_subnet = input(:target_subnet, value: '', description: '')

control 'aws-ec2-client-vpn-routes-1.0' do
  title 'Test the properties of the vpn routes.'

  describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: client_vpn_endpoint_id) do
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
