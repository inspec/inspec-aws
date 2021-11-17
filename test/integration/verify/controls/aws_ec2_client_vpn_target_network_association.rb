# frozen_string_literal: true
client_vpn_endpoint_id = attribute("client_vpn_endpoint_id", value: "", description: "")
association_id = attribute("association_id", value: "", description: "")

control 'aws_ec2_client_vpn_target_network_association-1.0' do
  impact 1.0
  title 'Test the properties of the vpn target network association.'

  describe aws_ec2_client_vpn_target_network_association(client_vpn_endpoint_id: client_vpn_endpoint_id, association_id: "cvpn-assoc-0f27d23309225bcbb") do
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
