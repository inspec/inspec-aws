aws_nat_gateway_name = input(:aws_nat_gateway_name, value: '', description: 'The value of the name tag of the nat gateway.')
aws_nat_gateway_id = input(:aws_nat_gateway_id, value: '', description: 'The ID of the nat gateway.')
aws_nat_gateway_subnet_id = input(:aws_nat_gateway_subnet_id, value: '', description: 'The subnet ID of the subnet in which the nat gateway is placed.')
aws_nat_gateway_allocation_id = input(:aws_nat_gateway_allocation_id, value: '', description: 'The allocation ID of the elastic IP address for the gateway.')
aws_nat_gateway_vpc_id = input(:aws_nat_gateway_vpc_id, value: '', description: 'The ID of the VPC in which the nat gateway is located.')
aws_nat_gateway_private_ip = input(:aws_nat_gateway_private_ip, value: '', description: 'The private Ip address of the nat gateway.')
aws_nat_gateway_public_ip = input(:aws_nat_gateway_public_ip, value: '', description: 'The public Ip address of the nat gateway.')

title 'Test multiple AWS NAT Gateways'

control 'aws-nat-gateways-1.0' do
  title 'Check AWS NAT gateways have the correct properties.'

  describe aws_nat_gateways do
    it { should exist }
    its('count') { should be >= 1 }
    its('states') { should include('available') }
    its('names') { should include(aws_nat_gateway_name) }
    its('vpc_ids') { should include(aws_nat_gateway_vpc_id) }
    its('subnet_ids') { should include(aws_nat_gateway_subnet_id) }
  end
  
  # Same test with using the singular resource
  aws_nat_gateways.where(name: aws_nat_gateway_name).ids.each do |id|
    describe aws_nat_gateway(id: id) do
      its('id') { should eq aws_nat_gateway_id }
      its('vpc_id') { should eq aws_nat_gateway_vpc_id }
      its('subnet_id') { should eq aws_nat_gateway_subnet_id }
      its('nat_gateway_address_set') { should include(:allocation_id => aws_nat_gateway_allocation_id) }
      its('nat_gateway_address_set') { should include(:private_ip => aws_nat_gateway_private_ip) }
      its('nat_gateway_address_set') { should include(:public_ip => aws_nat_gateway_public_ip) }
    end
  end
end
