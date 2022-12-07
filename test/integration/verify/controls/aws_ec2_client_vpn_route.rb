client_vpn_endpoint_id = input(:client_vpn_endpoint_id, value: '', description: '')
target_subnet = input(:target_subnet, value: '', description: '')

control 'aws-ec2-client-vpn-route-1.0' do
  impact 1.0
  title 'Test the properties of the vpn routes.'

  describe aws_ec2_client_vpn_route(client_vpn_endpoint_id:  client_vpn_endpoint_id, target_subnet: target_subnet) do
    it { should exist }
    its('origin') { should eq 'associate' }
    its('destination_cidr') { should eq '172.31.0.0/16' }
    its('target_subnet') { should eq target_subnet }
    its('client_vpn_endpoint_id') { should eq client_vpn_endpoint_id }
    its('status.code') { should eq 'active' }
    its('status.messages') { should eq nil }
    its('type') { should eq 'Nat' }
  end
end