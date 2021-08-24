control 'aws-ec2-local-gateway-routes-1.0' do
  impact 1.0
  title 'Test a plural resource of the local gateway routes.'

  describe aws_ec2_local_gateway_routes(local_gateway_route_table_id: 'rtb-07ad0ece8b2d6c914') do
    it { should exist }
  end

  describe aws_ec2_local_gateway_routes(local_gateway_route_table_id: 'rtb-07ad0ece8b2d6c914') do
    its('destination_cidr_blocks') { should include "zzzzzzzzzzzzzzzz" }
    its('local_gateway_virtual_interface_group_ids') { should include "zzzzzzzzzzzzzzzz" }
    its('type') { should include "zzzzzzzzzzzzzzzz" }
    its('states') { should include "zzzzzzzzzzzzzzzz" }
    its('local_gateway_route_table_ids') { should include "zzzzzzzzzzzzzzzz" }
    its('local_gateway_route_table_arns') { should include "zzzzzzzzzzzzzzzz" }
    its('owner_ids') { should include "zzzzzzzzzzzzzzzz" }
  end
end