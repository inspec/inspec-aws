control 'aws-ec2-network-firewall-firewalls-1.0' do
  impact 1.0
  title 'Test a plural resource of the aws network firewall firewalls.'

  describe aws_network_firewall_firewalls do
    it { should exist }
  end

  describe aws_network_firewall_firewalls do
    its('firewall_names') { should include '' }
    its('firewall_arns') { should include '' }
  end
end