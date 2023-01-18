skip_control 'aws-network-manager-global-networks-1.0' do
  title 'Verifies the settings of the network manager global network.'

  describe aws_network_manager_global_networks do
    it { should exist }
  end

  describe aws_network_manager_global_networks do
    its("global_network_ids") { should include 'GlobalNetworkID' }
    its("global_network_arns") { should include "GlobalNetworkARN" }
    its("descriptions") { should_not include "Test_Description" }
    its("created_at") { should_not be_empty }
    its("states") { should include "AVAILABLE" }
    its("tags") { should be_empty }
  end
end
