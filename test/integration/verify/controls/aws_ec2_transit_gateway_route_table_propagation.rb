control 'aws-ec2-transit-gateway-route-table-propagation-1.0' do
  impact 1.0
  title 'Describes information about the route table propagations for the specified transit gateway route table.'

  describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'tgw-rtb-0a9fa94cc48190745') do
    it { should exist }
  end

  describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'tgw-rtb-0a9fa94cc48190745') do
    its ('transit_gateway_attachment_id') { should eq 'tgw-attach-03a924ff49189ecb2'}
    its ('resource_id') { should eq 'vpc-07a4f94898fbdf788'}
    its ('resource_type') { should eq 'vpc'}
    its ('state') { should eq 'enabled'}
  end

  describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'tgw-rtb-1234567890') do
    it { should_not exist }
  end
end