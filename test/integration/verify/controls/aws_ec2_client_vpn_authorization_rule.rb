# frozen_string_literal: true
client_vpn_endpoint_id = attribute('client_vpn_endpoint_id', value: '', description: '')

skip_control 'aws_ec2_client_vpn_authorization_rule-1.0' do
  impact 1.0
  title 'Test the properties of the vpn authorization rule.'

  describe aws_ec2_client_vpn_authorization_rule(client_vpn_endpoint_id: client_vpn_endpoint_id, group_id: 'TEST_ID') do
    it { should exist }
    its('client_vpn_endpoint_id') { should eq client_vpn_endpoint_id }
    its('destination_cidr') { should eq "0.0.0.0/0" }
    its('group_id') { should_not eq 'TEST_ID' }
    its('access_all') { should eq false }
    its('status.code') { should eq 'active' }
    its('status.message') { should eq nil }
    its('description') { should eq nil }
  end
end