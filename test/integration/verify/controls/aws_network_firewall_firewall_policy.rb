control 'aws-network-firewall-policy-1.0' do
  impact 1.0
  title 'Test a singular resource of the aws network firewall policy.'

  describe aws_network_firewall_policy(firewall_policy_name: 'FirewallPolicyName') do
    it { should exist }
  end

  describe aws_network_firewall_policy(firewall_policy_name: 'FirewallPolicyName') do
    its('firewall_policy_response.firewall_policy_name') { should eq '' }
    its('firewall_policy_response.firewall_policy_arn') { should eq '' }
    its('firewall_policy_response.firewall_policy_id') { should eq '' }
    its('firewall_policy_response.description') { should eq '' }
    its('firewall_policy_response.firewall_policy_status') { should eq '' }
    its('firewall_policy_response.tags') { should eq '' }

    its('firewall_policy.stateless_rule_group_references') { should eq '' }
    its('firewall_policy.stateless_rule_group_references.first.resource_arn') { should eq '' }
    its('firewall_policy.stateless_rule_group_references.first.priority') { should eq '' }
    its('firewall_policy.stateless_default_actions') { should eq '' }
    its('firewall_policy.stateless_fragment_default_actions') { should eq '' }
    its('firewall_policy.stateless_custom_actions') { should eq '' }
    its('firewall_policy.stateless_custom_actions.first.action_name') { should eq '' }
    its('firewall_policy.stateless_custom_actions.first.action_definition.publish_metric_action.dimensions') { should eq '' }
    its('firewall_policy.stateless_custom_actions.first.action_definition.publish_metric_action.dimensions.first.value') { should eq '' }
    its('firewall_policy.stateful_rule_group_references') { should eq '' }
    its('firewall_policy.stateful_rule_group_references.first.resource_arn') { should eq '' }
  end
end