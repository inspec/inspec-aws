aws_networkfirewall_firewall_name = input(:aws_networkfirewall_firewall_name, value: '', description: '')
aws_networkfirewall_firewall_policy_name = input(:aws_networkfirewall_firewall_policy_name, value: '', description: '')
aws_networkfirewall_firewall_arn = input(:aws_networkfirewall_firewall_arn, value: '', description: '')
aws_networkfirewall_firewall_policy_id = input(:aws_networkfirewall_firewall_policy_id, value: '', description: '')

control 'aws-network-firewall-policy-1.0' do
  impact 1.0
  title 'Test a singular resource of the aws network firewall policy.'

  describe aws_network_firewall_policy(firewall_policy_name: aws_networkfirewall_firewall_name) do
    it { should exist }
  end

  describe aws_network_firewall_policy(firewall_policy_name: aws_networkfirewall_firewall_name) do
    its('firewall_policy_response.firewall_policy_name') { should eq aws_networkfirewall_firewall_policy_name }
    its('firewall_policy_response.firewall_policy_arn') { should eq aws_networkfirewall_firewall_arn }
    its('firewall_policy_response.firewall_policy_id') { should eq aws_networkfirewall_firewall_policy_id }
    its('firewall_policy_response.description') { should_not be_empty }
    its('firewall_policy_response.firewall_policy_status') { should_not be_empty }
    its('firewall_policy_response.tags') { should_not be_empty }

    its('firewall_policy.stateless_rule_group_references') { should_not be_empty }
    its('firewall_policy.stateless_rule_group_references.first.resource_arn') { should_not be_empty }
    its('firewall_policy.stateless_rule_group_references.first.priority') { should eq '' }
    its('firewall_policy.stateless_default_actions') { should_not be_empty }
    its('firewall_policy.stateless_fragment_default_actions') { should_not be_empty }
    its('firewall_policy.stateless_custom_actions') { should_not be_empty }
    its('firewall_policy.stateless_custom_actions.first.action_name') { should_not be_empty }
    its('firewall_policy.stateless_custom_actions.first.action_definition.publish_metric_action.dimensions') { should_not be_empty }
    its('firewall_policy.stateless_custom_actions.first.action_definition.publish_metric_action.dimensions.first.value') { should_not be_empty }
    its('firewall_policy.stateful_rule_group_references') { should_not be_empty }
    its('firewall_policy.stateful_rule_group_references.first.resource_arn') { should_not be_empty }
  end

  describe aws_network_firewall_policy(firewall_policy_name: 'dummy') do
    it { should_not exist }
  end
end
