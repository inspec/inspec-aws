skip_control 'aws-network-manager-customer-gateway-associations-1.0' do
  title 'Test the properties of the aws network manager customer gateway associations.'

  describe aws_network_manager_customer_gateway_associations(global_network_id: 'GlobalNetworkID') do
    it { should exist }
  end

  describe aws_network_manager_customer_gateway_associations(global_network_id: 'GlobalNetworkID') do
    its('customer_gateway_arns') { should include 'CustomerGatewayARN' }
    its('global_network_ids') { should include 'GlobalNetworkID' }
    its('device_ids') { should include 'DeviceID' }
    its('link_ids') { should include 'LinkID' }
    its('states') { should include 'State' }
  end
end
