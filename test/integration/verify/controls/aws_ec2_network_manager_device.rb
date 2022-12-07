title 'Test a AWS Network Device bulk'

skip_control 'aws-network-manager-device-1.0' do
  impact 1.0
  title 'Ensure AWS Network Device resource has the correct properties.'

  describe aws_network_manager_device(device_id: 'test1', global_network_id: 'test1') do
    it { should exist }
    its('device_id') { should eq 'test-device' }
    its('device_arn') { should eq 'test-device-arn' }
  end
end
