client_vpn_endpoint_id = input(:client_vpn_endpoint_id, value: '', description: '')
association_id = input(:association_id, value: '', description: '')

control 'aws-ec2-client-vpn-target-network-association-1.0' do
  title 'Test the properties of the vpn target network association.'

  describe aws_ec2_client_vpn_target_network_association(client_vpn_endpoint_id: client_vpn_endpoint_id, association_id: association_id) do
    it { should exist }
    its('association_id') { should eq association_id }
    its('vpc_id') { should_not eq 'vpc-6d9d7505' }
    its('target_network_id') { should_not eq 'subnet-700ff218' }
    its('client_vpn_endpoint_id') { should eq client_vpn_endpoint_id }
    its('status.code') { should eq 'associated' }
    its('status.messages') { should eq nil }
    its('security_groups') { should_not include 'sg-ca1e3aa2' }
  end
end
