aws_customer_gateway_id = input(:aws_customer_gateway_id, value: '', description: '')

control 'aws-ec2-customer-gateway-1.0' do
  title 'Test the properties of the EC2 Customer Gateway.'

  describe aws_ec2_customer_gateway(customer_gateway_id: aws_customer_gateway_id) do
    it { should exist }
  end

  describe aws_ec2_customer_gateway(customer_gateway_id: aws_customer_gateway_id) do
    its('bgp_asn') { should eq '65000' }
    its('customer_gateway_id') { should eq aws_customer_gateway_id }
    its('ip_address') { should_not be_empty }
    its('certificate_arn') { should be_empty }
    its('state') { should eq 'available' }
    its('device_name') { should be_empty }
    its('tags') { should_not be_empty }
  end
end
