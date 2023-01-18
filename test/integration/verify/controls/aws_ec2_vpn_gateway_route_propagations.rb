aws_route_table_first_id = input(:aws_route_table_first_id, value: '', description: 'The AWS route table ID.')

control 'aws-ec2-vpn-gateway-route-propagations-1.0' do
  title 'List the virtual private gateway (VGW) to propagate routes to the specified route table of a VPC.'

  describe aws_ec2_vpn_gateway_route_propagations do
    it { should exist }
  end

  describe aws_ec2_vpn_gateway_route_propagations do
    its('route_table_ids') { should include aws_route_table_first_id }
    its('propagating_vgws_gateway_ids') { should be_empty }
  end
end
