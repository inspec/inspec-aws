aws_networkfirewall_rule_group_arn = input(:aws_networkfirewall_rule_group_arn, value: '', description: '')
aws_networkfirewall_rule_group_name = input(:aws_networkfirewall_rule_group_name, value: '', description: '')
aws_networkfirewall_rule_group_capacity = input(:aws_networkfirewall_rule_group_capacity, value: '', description: '')
aws_networkfirewall_rule_group_type = input(:aws_networkfirewall_rule_group_type, value: '', description: '')

control 'aws-network-firewall-rule-group-1.0' do
  title 'Test a singular resource of the aws network firewall rule group.'

  describe aws_network_firewall_rule_group(rule_group_arn: aws_networkfirewall_rule_group_arn) do
    it { should exist }
  end

  describe aws_network_firewall_rule_group(rule_group_arn: aws_networkfirewall_rule_group_arn) do
    its('update_token') { should_not be_empty }

    its('rule_group_response.rule_group_arn') { should eq aws_networkfirewall_rule_group_arn }
    its('rule_group_response.rule_group_name') { should eq aws_networkfirewall_rule_group_name }
    its('rule_group_response.description') { should be_empty }
    its('rule_group_response.type') { should eq aws_networkfirewall_rule_group_type }
    its('rule_group_response.capacity') { should eq aws_networkfirewall_rule_group_capacity }
    its('rule_group_response.rule_group_status') { should eq 'ACTIVE' }
    its('rule_group_response.tags') { should_not be_empty }
  end

  describe aws_network_firewall_rule_group(rule_group_arn: 'dummy') do
    it { should_not exist }
  end
end
