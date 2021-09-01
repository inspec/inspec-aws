control 'aws-ec2-network-firewall-rule-groups-1.0' do
  impact 1.0
  title 'Test a plural resource of the aws network firewall rule groups.'

  describe aws_network_firewall_rule_groups do
    it { should exist }
  end

  describe aws_network_firewall_rule_groups do
    its('names') { should include '' }
    its('arns') { should include '' }
  end
end