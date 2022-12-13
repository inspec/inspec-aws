skip_control 'aws-network-manager-global-network-1.0' do
  title 'Verifies the settings of the network manager global network.'

  describe aws_network_manager_global_network(global_network_id: 'GlobalNetworkID') do
    it { should exist }
  end

  describe aws_network_manager_global_network(global_network_id: 'GlobalNetworkID') do
    its("global_network_id") { should eq 'GlobalNetworkID' }
    its("global_network_arn") { should eq "GlobalNetworkARN" }
    its("description") { should_not eq "Test_Description" }
    its("created_at") { should_not be_empty }
    its("state") { should eq "AVAILABLE" }
    its("tags") { should be_empty }
  end
end
