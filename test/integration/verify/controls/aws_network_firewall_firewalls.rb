aws_networkfirewall_firewall_policy_arn = input(:aws_networkfirewall_firewall_policy_arn, value: '', description: '')
aws_networkfirewall_firewall_name = input(:aws_networkfirewall_firewall_name, value: '', description: '')

control 'aws-network-firewall-firewalls-1.0' do
  impact 1.0
  title 'Test the properties of the aws network firewall firewalls.'

  describe aws_network_firewall_firewalls do
    it { should exist }
  end

  describe aws_network_firewall_firewalls do
    its('firewall_names') { should include aws_networkfirewall_firewall_name }
    its('firewall_arns') { should include aws_networkfirewall_firewall_policy_arn }
  end
end
