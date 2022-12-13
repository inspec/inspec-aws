client_vpn_endpoint_id = input(:client_vpn_endpoint_id, value: '', description: '')

skip_control 'aws-ec2-client-vpn-authorization-rules-1.0' do
  title 'Test the properties of the vpn authorization rules.'

  describe aws_ec2_client_vpn_authorization_rules(client_vpn_endpoint_id: client_vpn_endpoint_id) do
    it { should exist }
    its('client_vpn_endpoint_ids') { should include client_vpn_endpoint_id }
    its('destination_cidr') { should include '0.0.0.0/0' }
    its('group_ids') { should_not include 'TEST_ID' }
    its('access_all') { should include false }
    its('status_codes') { should include 'active' }
    its('status_messages') { should include nil }
    its('descriptions') { should include nil }
  end
end
