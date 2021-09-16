title 'Test a AWS Network Device bulk'
skip_control 'aws_network_manager_devices-1.0' do

  impact 1.0
  title 'Ensure AWS Network Device resource has the correct properties.'

  describe aws_network_manager_devices do
    it { should exist }
    its('device_ids') { should be "test-device" }
    its('device_arns') { should include "test-device-arns"  }
  end
end

