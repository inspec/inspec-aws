control 'aws-network-firewall-firewall-1.0' do
  impact 1.0
  title 'Test a singular resource of the aws network firewall firewall.'

  describe aws_network_firewall_firewall(firewall_name: 'FirewallName') do
    it { should exist }
  end

  describe aws_network_firewall_firewall(firewall_name: 'FirewallName') do
    its('firewall.firewall_name') { should eq '' }
    its('firewall.firewall_arn') { should eq '' }
    its('firewall.firewall_policy_arn') { should eq '' }
    its('firewall.vpc_id') { should eq '' }
    its('firewall.subnet_mappings') { should eq '' }
    its('firewall.subnet_mappings.first.subnet_id') { should eq '' }
    its('firewall.delete_protection') { should eq true }
    its('firewall.subnet_change_protection') { should eq '' }
    its('firewall.firewall_policy_change_protection') { should eq '' }
    its('firewall.description') { should eq '' }
    its('firewall.firewall_id') { should eq '' }
    its('firewall.tags') { should eq '' }

    its('firewall_status.status') { should eq '' }
    its('firewall_status.configuration_sync_state_summary') { should eq '' }
    its('firewall_status.sync_states') { should eq '' }
    its('firewall_status.sync_states["AvailabilityZone"].attachment.subnet_id') { should eq '' }
    its('firewall_status.sync_states["AvailabilityZone"].attachment.endpoint_id') { should eq '' }
    its('firewall_status.sync_states["AvailabilityZone"].attachment.status') { should eq '' }
    its('firewall_status.sync_states["AvailabilityZone"].config') { should eq '' }
    its('firewall_status.sync_states["AvailabilityZone"].config["ResourceName"].sync_status') { should eq '' }
    its('firewall_status.sync_states["AvailabilityZone"].config["ResourceName"].update_token') { should eq '' }
  end
end
