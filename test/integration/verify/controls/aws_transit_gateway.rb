title 'Test AWS Transit Gateway'

aws_kms_key_enabled_id = attribute(:aws_transit_gateway_id, default: '', description: 'The AWS Transit Gateway ID.')

control 'aws-transit-gateway-1.0' do

  impact 1.0
  title 'Ensure AWS VPC Subnets plural resource has the correct properties.'

  describe aws_transit_gateway(transit_gateway_id: aws_kms_key_enabled_id) do
    it { should exist }
  end

end