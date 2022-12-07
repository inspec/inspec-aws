skip_control 'aws-network-manager-customer-gateway-association-1.0' do
  impact 1.0
  title 'Test the properties of the aws network manager customer gateway association.'

  describe aws_network_manager_customer_gateway_association(global_network_id: 'GlobalNetworkID', customer_gateway_arn: 'CustomerGatewayARN') do
    it { should exist }
  end

  describe aws_network_manager_customer_gateway_association(global_network_id: 'GlobalNetworkID', customer_gateway_arn: 'CustomerGatewayARN') do
    its('customer_gateway_arn') { should eq 'CustomerGatewayARN' }
    its('global_network_id') { should eq 'GlobalNetworkID' }
    its('device_id') { should eq 'DeviceID' }
    its('link_id') { should eq 'LinkID' }
    its('state') { should eq 'State' }
  end
end