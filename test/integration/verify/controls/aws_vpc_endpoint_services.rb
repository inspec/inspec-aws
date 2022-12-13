title 'Test All AWS VPC Endpoint Services'

aws_vpc_service_name = input(:aws_vpc_endpoint_service_name, value: '', description: 'The VPC Endpoint service name')

control 'aws-vpc-endpoint-services-1.0' do
  title 'Ensure AWS VPC Endpoint Services resource has the correct properties.'

  describe aws_vpc_endpoint_services do
    it { should exist }
  end

  describe aws_vpc_endpoint_services do
    its('service_names') { should include aws_vpc_service_name }
  end
end

