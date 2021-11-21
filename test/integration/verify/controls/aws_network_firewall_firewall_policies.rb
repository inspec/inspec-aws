aws_networkfirewall_firewall_policy_name = attribute("aws_networkfirewall_firewall_policy_name", value: "", description: "")
aws_networkfirewall_firewall_arn = attribute("aws_networkfirewall_firewall_arn", value: "", description: "")

control 'aws-ec2-network-firewall-policies-1.0' do
  impact 1.0
  title 'Test a plural resource of the aws network firewall policy.'

  describe aws_network_firewall_policies do
    it { should exist }
  end

  describe aws_network_firewall_policies do
    its('names') { should include aws_networkfirewall_firewall_policy_name }
    its('arns') { should include aws_networkfirewall_firewall_arn }
  end
end