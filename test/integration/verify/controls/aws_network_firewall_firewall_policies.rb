control 'aws-ec2-network-firewall-policies-1.0' do
  impact 1.0
  title 'Test a plural resource of the aws network firewall policy.'

  describe aws_network_firewall_policies do
    it { should exist }
  end

  describe aws_network_firewall_policies do
    its('names') { should include '' }
    its('arns') { should include '' }
  end
end