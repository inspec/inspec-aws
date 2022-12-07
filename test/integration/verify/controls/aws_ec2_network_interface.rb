aws_network_interface_id = input(:aws_network_interface_id, value: '', description: '')

control 'aws-ec2-network-interface-1.0' do
  impact 1.0
  title 'Test a singular resource of the aws ec2 network interfaces.'

  describe aws_ec2_network_interface(network_interface_id: aws_network_interface_id) do
    it { should exist }
  end

  describe aws_ec2_network_interface(network_interface_id: aws_network_interface_id) do
    its('association') { should be_empty }
    its('availability_zone') { should eq 'us-east-2c' }
    its('groups') { should be_empty }
    its('interface_type') { should eq 'interface' }
    its('ipv_6_addresses') { should be_empty }
  end
end