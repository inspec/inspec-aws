title 'Test single AWS VPN Endpoint Service Permission'

aws_vpc_endpoint_service_id = input(:aws_vpc_endpoint_service_id, value: '', description: 'The unique identifier for VPC endpoint Service')
aws_vpc_endpoint_service_allowed_principal_arn = input(:aws_vpc_endpoint_service_allowed_principal_arn, value: '', description: 'AWS ARN of the user/account to allow permissions')

control 'aws-vpc-endpoint-service-permission-1.0' do
  impact 1.0
  title 'Ensure AWS VPN Endpoint Service Permission has the correct properties.'

  describe aws_vpc_endpoint_service_permission(service_id: aws_vpc_endpoint_service_id, principal: aws_vpc_endpoint_service_allowed_principal_arn) do
    it { should exist }
    it { should be_principal_type_user }
    it { should_not be_principal_type_role }
    it { should_not be_principal_type_account }
    it { should_not be_principal_type_organization_unit }
    it { should_not be_principal_type_service }
    its('principal_type') { should eq 'User' }
  end
end
