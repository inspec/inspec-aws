control 'aws-ec2-transit-gateway-route-table-propagations-1.0' do
  impact 1.0
  title 'Lists information about the route table propagations for the specified transit gateway route table.'

  describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'tgw-rtb-0a9fa94cc48190745') do
    it { should exist }
  end

  describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'tgw-rtb-0a9fa94cc48190745') do
    its ('transit_gateway_attachment_ids') { should include 'tgw-attach-03a924ff49189ecb2'}
    its ('resource_ids') { should include 'vpc-07a4f94898fbdf788'}
    its ('resource_types') { should include 'vpc'}
    its ('states') { should include 'enabled'}
  end
end