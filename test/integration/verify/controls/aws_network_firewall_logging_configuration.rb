aws_networkfirewall_firewall_name = input(:aws_networkfirewall_firewall_name, value: '', description: '')
aws_networkfirewall_firewall_arn = input(:aws_networkfirewall_firewall_arn, value: '', description: '')

control 'aws-network-firewall-logging-configuration-1.0' do
  impact 1.0
  title 'Test a singular resource of the aws network firewall logging configuration.'

  describe aws_network_firewall_logging_configuration(firewall_name: aws_networkfirewall_firewall_name) do
    it { should exist }
  end

  describe aws_network_firewall_logging_configuration(firewall_name: aws_networkfirewall_firewall_name) do
    its('firewall_arn') { should eq aws_networkfirewall_firewall_arn }
    its('logging_configuration.log_destination_configs') { should_not be_empty }
    its('logging_configuration_log_destination_configs_log_type') { should be_empty }
    its('logging_configuration_log_destination_configs_log_destination_type') { should be_empty }
    its('logging_configuration_log_destination_configs_log_destination') { should be_empty }
  end

  describe aws_network_firewall_logging_configuration(firewall_name: 'dummy') do
    it { should_not exist }
  end
end
