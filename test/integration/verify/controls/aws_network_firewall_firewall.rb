aws_networkfirewall_firewall_policy_arn = input(:aws_networkfirewall_firewall_policy_arn, value: '', description: '')
aws_networkfirewall_firewall_name = input(:aws_networkfirewall_firewall_name, value: '', description: '')
aws_networkfirewall_firewall_vpc_id = input(:aws_networkfirewall_firewall_vpc_id, value: '', description: '')

control 'aws-network-firewall-firewall-1.0' do
  impact 1.0
  title 'Test the properties of the aws network firewall firewall.'

  describe aws_network_firewall_firewall(firewall_name: aws_networkfirewall_firewall_name) do
    it { should exist }
  end

  describe aws_network_firewall_firewall(firewall_name: aws_networkfirewall_firewall_name) do
    its('update_token') { should_not be_empty }

    its('firewall.firewall_name') { should eq aws_networkfirewall_firewall_name }
    its('firewall.firewall_arn') { should eq aws_networkfirewall_firewall_policy_arn }
    its('firewall.firewall_policy_arn') { should eq aws_networkfirewall_firewall_policy_arn }
    its('firewall.vpc_id') { should eq aws_networkfirewall_firewall_vpc_id }
    its('firewall_status.status') { should eq 'READY' }
    its('firewall_status.configuration_sync_state_summary') { should eq 'IN_SYNC' }
  end

  describe aws_network_firewall_firewall(firewall_name: 'dummy') do
    it { should_not exist }
  end
end
