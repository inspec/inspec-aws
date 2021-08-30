control 'aws-network-manager-global-networks-1.0' do
  impact 1.0
  title 'List all the global networks.'

  describe aws_network_manager_global_networks do
    it { should exist }
  end

  describe aws_network_manager_global_networks do
    its('global_network_ids') { should include '' }
    its('global_network_arns') { should include '' }
    its('descriptions') { should include '' }
    its('created_at') { should include '' }
    its('states') { should include '' }
    its('tags') { should include '' }
  end
end
