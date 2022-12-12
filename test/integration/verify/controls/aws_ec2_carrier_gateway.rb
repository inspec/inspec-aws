skip_control 'aws-ec2-carrier-gateway-1.0' do
  title 'Describes one or more of ec2 carrier gateway.'

  describe aws_ec2_carrier_gateways do
    it { should exist }
  end

  describe aws_ec2_carrier_gateways do
    its('carrier_gateway_ids') { should include 'cagw-0e0bcd57d5dfee6a1' }
    its('vpc_ids') { should_not be_empty }
    its('states') { should_not be_empty }
    its('owner_ids') { should include '112758395563' }
    its('tags') { should_not be_empty }
  end
end


