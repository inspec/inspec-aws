control 'aws-network-manager-devices-1.0' do
  impact 1.0
  title 'List all the devices.'

  describe aws_network_manager_devices do
    it { should exist }
  end

  describe aws_network_manager_devices do
    its('device_ids') { should include '' }
    its('device_arns') { should include '' }
    its('global_network_ids') { should include '' }
    its('aws_locations') { should include '' }
    its('descriptions') { should include '' }
    its('types') { should include '' }
    its('vendors') { should include '' }
    its('models') { should include '' }
    its('serial_numbers') { should include '' }
    its('locations') { should include '' }
    its('site_ids') { should include '' }
    its('created_at') { should include '' }
    its('states') { should include '' }
    its('tags') { should include '' }
  end
end