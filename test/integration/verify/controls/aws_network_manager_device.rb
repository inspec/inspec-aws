control 'aws-network-manager-device-1.0' do
  impact 1.0
  title 'Describes one or more devices.'

  describe aws_network_manager_device(device_id: "DeviceID") do
    it { should exist }
  end

  describe aws_network_manager_device(device_id: "DeviceID") do
    its('device_id') { should eq '' }
    its('device_arn') { should eq '' }
    its('global_network_id') { should eq '' }
    its('description') { should eq '' }
    its('type') { should eq '' }
    its('vendor') { should eq '' }
    its('model') { should eq '' }
    its('serial_number') { should eq '' }
    its('site_id') { should eq '' }
    its('created_at') { should eq '' }
    its('state') { should eq '' }
    its('tags') { should eq '' }
  end

  describe aws_network_manager_device(device_id: "DeviceID") do
    its('aws_location.zone') { should eq '' }
    its('aws_location.subnet_arn') { should eq '' }
  end

  describe aws_network_manager_device(device_id: "DeviceID") do
    its('location.address') { should eq '' }
    its('location.latitude') { should eq '' }
    its('location.longitude') { should eq '' }
  end

  describe aws_network_manager_device(device_id: "dummy") do
    it { should_not exist }
  end
end
