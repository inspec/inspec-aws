aws_customer_gateway_id = input(:aws_customer_gateway_id, value: '', description: '')

control 'aws-ec2-customer-gateways-1.0' do
  title 'Test the properties of the EC2 Customer Gateways.'

  describe aws_ec2_customer_gateways do
    it { should exist }
  end

  describe aws_ec2_customer_gateways do
    its('bgp_asns') { should include '65000' }
    its('customer_gateway_ids') { should include aws_customer_gateway_id }
    its('ip_addresses') { should_not be_empty }
    its('certificate_arns') { should_not be_empty }
    its('states') { should include 'available' }
    its('device_names') { should_not be_empty }
    its('tags') { should_not be_empty }
  end
end
