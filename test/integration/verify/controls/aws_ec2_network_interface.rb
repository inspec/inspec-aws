control 'aws-ec2-network-interface-1.0' do
  impact 1.0
  title 'Test a singular resource of the aws ec2 network interfaces.'

  describe aws_ec2_network_interface(network_interface_id: 'eni-08e0621ce9bc8dc56') do
    it { should exist }
  end

  describe aws_ec2_network_interface(network_interface_id: 'eni-08e0621ce9bc8dc56') do
    its('association') { should be_empty }
    its('availability_zone') { should eq "us-east-2c" }
    its('description') { should eq "Network Interface for Transit Gateway Attachment tgw-attach-03a924ff49189ecb2" }
    its('groups') { should be_empty }
    its('interface_type') { should eq "transit_gateway" }
    its('ipv_6_addresses') { should be_empty }
  end
end