aws_networkfirewall_rule_group_arn = input(:aws_networkfirewall_rule_group_arn, value: '', description: '')
aws_networkfirewall_rule_group_name = input(:aws_networkfirewall_rule_group_name, value: '', description: '')

control 'aws-ec2-network-firewall-rule-groups-1.0' do
  impact 1.0
  title 'Test a plural resource of the aws network firewall rule group.'

  describe aws_network_firewall_rule_groups do
    it { should exist }
  end

  describe aws_network_firewall_rule_groups do
    its('names') { should include aws_networkfirewall_rule_group_name }
    its('arns') { should include aws_networkfirewall_rule_group_arn }
  end
end
