client_vpn_endpoint_id = input(:client_vpn_endpoint_id, value: '', description: '')
association_id = input(:association_id, value: '', description: '')

control 'aws-ec2-client-vpn-target-network-associations-1.0' do
  title 'Test the properties of the vpn target network associations.'

  describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: client_vpn_endpoint_id) do
    it { should exist }
    its('association_ids') { should_not include association_id }
    its('vpc_ids') { should_not include 'vpc-6d9d7505' }
    its('target_network_ids') { should_not include 'subnet-700ff218' }
    its('client_vpn_endpoint_ids') { should include client_vpn_endpoint_id }
    its('status_codes') { should include 'associated' }
    its('status_messages') { should include nil }
    its('security_groups') { should_not include 'sg-ca1e3aa2' }
  end
end
