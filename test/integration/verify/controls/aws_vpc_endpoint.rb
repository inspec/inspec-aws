title 'Test Single AWS VPC Endpoint'

aws_vpce_id = attribute(:aws_vpce_id, default: '', description: 'The AWS VPC Endpoint ID.')
aws_vpce_name = attribute(:aws_vpc_endpoint_name, default: '', description: 'The AWS VPC Endpoint Name.')
aws_vpc_id = attribute(:aws_vpc_id, default: '', description: 'The VPC ID where the endpoint resides')
aws_vpce_service_name = attribute(:aws_vpce_service_name, default: '', description: 'The VPC Endpoint service name')
aws_route_table_first_id = attribute(:aws_route_table_first_id, default: '', description: 'The VPC Endpoint Route Table ID')

control 'aws-vpcendpoint-1.0' do

  impact 1.0
  title 'Ensure AWS VPC Endpoint single resource has the correct properties.'

  describe aws_vpc_endpoint(vpc_endpoint_id: aws_vpce_id) do
    it { should exist }
    its('vpc_endpoint_id')       { should cmp aws_vpce_id }
    its('vpc_endpoint_type')     { should be_in ["Interface", "Gateway"] }
    its('vpc_id')               { should cmp aws_vpc_id }
    its('service_name')  { should cmp aws_vpce_service_name }
    its('state') { should be_in ["pendingpcceptance", "pending", "available", "deleting", "deleted", "rejected", "failed", "expired"] }
    its('route_table_ids')       { should include aws_route_table_first_id }
    its('private_dns_enabled')       { should be_in [true, false] }
    its('tags')              { should include('Name' => aws_vpce_name) }
  end

  describe aws_vpc_endpoint(aws_vpce_id) do
    it { should exist }
    its('vpc_endpoint_id')       { should cmp aws_vpce_id }
    its('vpc_endpoint_type')     { should be_in ["Interface", "Gateway"] }
    its('vpc_id')               { should cmp aws_vpc_id }
    its('service_name')  { should cmp aws_vpce_service_name }
    its('state') { should be_in ["pendingpcceptance", "pending", "available", "deleting", "deleted", "rejected", "failed", "expired"] }
    its('route_table_ids')       { should include aws_route_table_first_id }
    its('private_dns_enabled')       { should be_in [true, false] }
    its('tags')              { should include('Name' => aws_vpce_name) }
  end

end