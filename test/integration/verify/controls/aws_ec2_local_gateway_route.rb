skip_control 'aws-ec2-local-gateway-route-1.0' do
  impact 1.0
  title 'Test a singular resource of the local gateway route.'

  describe aws_ec2_local_gateway_route(local_gateway_route_table_id: 'rtb-07ad0ece8b2d6c914') do
    it { should exist }
  end

  describe aws_ec2_local_gateway_route(local_gateway_route_table_id: 'rtb-07ad0ece8b2d6c914') do
    its('destination_cidr_block') { should eq "" }
    its('local_gateway_virtual_interface_group_id') { should eq "" }
    its('type') { should eq "" }
    its('state') { should eq "" }
    its('local_gateway_route_table_id') { should eq "" }
    its('local_gateway_route_table_arn') { should eq "" }
    its('owner_id') { should eq "" }
  end
end