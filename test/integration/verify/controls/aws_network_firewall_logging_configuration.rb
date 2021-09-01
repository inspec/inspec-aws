control 'aws-network-firewall-logging-configuration-1.0' do
  impact 1.0
  title 'Test a singular resource of the aws network firewall logging configuration.'

  describe aws_network_firewall_logging_configuration(firewall_name: 'FirewallName') do
    it { should exist }
  end

  describe aws_network_firewall_logging_configuration(firewall_name: 'FirewallName') do
    its('log_type') { should eq '' }
    its('log_destination_type') { should eq '' }
    its('log_destination') { should eq '' }
    its('log_destination["HashMapKey"]') { should eq '' }
  end
end
