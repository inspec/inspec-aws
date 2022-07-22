title 'Test a AWS Network Device in bulk'

skip_control 'aws-network-manager-devices-1.0' do
  impact 1.0
  title 'Ensure AWS Network Devices resource has the correct properties.'

  describe aws_network_manager_devices(global_network_id: 'test1') do
    it { should exist }
    its('device_ids') { should eq 'test-device' }
    its('device_arns') { should include 'test-device-arns' }
  end
end

