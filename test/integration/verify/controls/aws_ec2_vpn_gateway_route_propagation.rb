aws_route_table_first_id = input(:aws_route_table_first_id, value: '', description: 'The AWS route table ID.')

control 'aws-ec2-vpn-gateway-route-propagation-1.0' do
  title 'Describes a virtual private gateway (VGW) to propagate routes to the specified route table of a VPC.'

  describe aws_ec2_vpn_gateway_route_propagation(route_table_id: aws_route_table_first_id) do
    it { should exist }
  end

  describe aws_ec2_vpn_gateway_route_propagation(route_table_id: aws_route_table_first_id) do
    its ('vpn_gateway_id') { should be_empty }
    its ('route_table_id') { should eq aws_route_table_first_id }
  end

  describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'rtb-1234567890') do
    it { should_not exist }
  end
end
