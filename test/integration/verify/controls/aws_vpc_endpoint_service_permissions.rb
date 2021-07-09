title 'Test all AWS VPN Endpoint Service Permissions'
aws_vpc_endpoint_service_id = attribute(:aws_vpc_endpoint_service_id, default: '', description: 'The unique identifier for VPC endpoint Service')
aws_vpc_endpoint_service_allowed_principal_arn = attribute(:aws_vpc_endpoint_service_allowed_principal_arn, default: '', description: 'AWS ARN of the user/account to allow permissions')

control 'aws-vpc-endpoint-service-permissions-1.0' do
  impact 1.0
  title 'Ensure AWS VPN Endpoint Service Permissions has the correct properties.'

  describe aws_vpc_endpoint_service_permissions(service_id: aws_vpc_endpoint_service_id) do
    it { should exist }
    its('principals') { should include aws_vpc_endpoint_service_allowed_principal_arn }
    its('principal_types') { should include 'User' }
  end

  describe aws_vpc_endpoint_service_permissions(service_id: aws_vpc_endpoint_service_id).where(principal_type: 'User') do
    it { should exist }
  end
end