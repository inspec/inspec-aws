aws_networkfirewall_firewall_policy_name = attribute("aws_networkfirewall_firewall_policy_name", value: "", description: "")
aws_networkfirewall_firewall_policy_arn = attribute("aws_networkfirewall_firewall_policy_arn", value: '', description: "")

control 'aws-network-firewall-policy-1.0' do
  impact 1.0
  title 'Test a plural resource of the aws network firewall policy.'

  describe aws_network_firewall_firewall_policy(firewall_policy_name: aws_networkfirewall_firewall_policy_name) do
    it { should exist }
  end

  describe aws_network_firewall_firewall_policy(firewall_policy_name: aws_networkfirewall_firewall_policy_name) do
    its('firewall_policy_response.firewall_policy_name') { should eq aws_networkfirewall_firewall_policy_name }
    its('firewall_policy_response.firewall_policy_arn') { should eq aws_networkfirewall_firewall_policy_arn }
    its('firewall_policy_response.firewall_policy_id') { should_not be_empty }
    its('firewall_policy_response.description') { should be_empty }
    its('firewall_policy_response.firewall_policy_status') { should eq 'ACTIVE' }
    its('firewall_policy_response.tags') { should be_empty }

    its('firewall_policy.stateless_rule_group_references') { should be_empty }
    its('firewall_policy.stateless_default_actions') { should eq ["aws:pass"] }
    its('firewall_policy.stateless_fragment_default_actions') { should eq ["aws:drop"] }
    its('firewall_policy.stateless_custom_actions') { should_not be_empty }
    its('firewall_policy.stateful_rule_group_references') { should be_empty }
  end
end