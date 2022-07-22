title 'Test AWS VPC Endpoints in bulk'

aws_vpce_id = input(:aws_vpce_id, value: '', description: 'The AWS VPC Endpoint ID.')
aws_vpce_name = input(:aws_vpc_endpoint_name, value: '', description: 'The AWS VPC Endpoint Name.')
aws_vpc_id = input(:aws_vpc_id, value: '', description: 'The VPC ID where the endpoint resides')
aws_vpce_service_name = input(:aws_vpce_service_name, value: '', description: 'The VPC Endpoint service name')
aws_route_table_first_id = input(:aws_route_table_first_id, value: '', description: 'The VPC Endpoint Route Table ID')

control 'aws-vpcendpoints-1.0' do
  impact 1.0
  title 'Ensure AWS VPC Endpoint plural resource has the correct properties.'

  describe aws_vpc_endpoints do
    it { should exist }
  end

  describe aws_vpc_endpoints do
    its('count') { should be <= 100 }
    its('vpc_endpoint_ids') { should include aws_vpce_id }
    its('vpc_endpoint_types') { should include "Gateway" }
    its('vpc_ids') { should include aws_vpc_id }
    its('service_names') { should include aws_vpce_service_name }
    its('states') { should include "available" }
    its('route_table_ids') { should include [aws_route_table_first_id] }
    its('private_dns_enabled') { should include false }
    its('tags') { should include('Name' => aws_vpce_name) }
  end
end