control 'aws-network-manager-global-network-1.0' do
  impact 1.0
  title 'Describes one or more global networks.'

  describe aws_network_manager_global_network(global_network_id: "GlobalNetworkID") do
    it { should exist }
  end

  describe aws_network_manager_global_network(global_network_id: "GlobalNetworkID") do
    its('global_network_id') { should eq '' }
    its('global_network_arn') { should eq '' }
    its('description') { should eq '' }
    its('created_at') { should eq '' }
    its('state') { should eq '' }
    its('tags') { should eq '' }
  end

  describe aws_network_manager_global_network(global_network_id: "dummy") do
    it { should_not exist }
  end
end
