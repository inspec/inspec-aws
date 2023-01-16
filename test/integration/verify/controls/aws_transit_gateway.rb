title 'Test AWS Transit Gateway'

aws_transit_gateway_id = input(:aws_transit_gateway_id, value: '', description: 'The AWS Transit Gateway ID.')

control 'aws-transit-gateway-1.0' do
  title 'Ensure AWS Transit gateway is configured correctly.'

  describe aws_transit_gateway(transit_gateway_id: aws_transit_gateway_id) do
    it { should exist }
  end
end
