title 'Test Single AWS VPC Endpoint Service'

aws_vpc_service_name = input(:aws_vpc_endpoint_service_name, value: '', description: 'The VPC Endpoint service name')
aws_vpc_endpoint_service_id = input(:aws_vpc_endpoint_service_id, value: '', description: 'The VPC Endpoint service ID')
aws_vpc_base_endpoint_dns_names = input(:aws_vpc_base_endpoint_dns_names, value: '', description: 'The VPC base endpoint DNS names')

control 'aws-vpc-endpoint-service-1.0' do
  impact 1.0
  title 'Ensure AWS VPC Endpoint Service single resource has the correct properties.'
  
  describe aws_vpc_endpoint_service(service_name: aws_vpc_service_name) do
    it { should exist }
    its('service_name') { should eq aws_vpc_service_name }
    its('service_id') { should eq aws_vpc_endpoint_service_id }
    its('service_type') { should eq 'Interface' }
    its('availability_zones') { should include 'us-east-2a' }
    its('owner') { should eq '112758395563' }
    its('base_endpoint_dns_names') { should include aws_vpc_base_endpoint_dns_names }
    its('private_dns_name') { should be_empty }
    it { should be_interface }
    it { should_not be_gateway_load_balancer }
    it { should_not be_vpc_endpoint_policy_supported }
    it { should be_acceptance_required }
    it { should_not be_manages_vpc_endpoints }
    it { should_not be_private_dns_name_verified }
  end
end
