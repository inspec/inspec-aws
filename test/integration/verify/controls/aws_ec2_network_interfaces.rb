control 'aws-ec2-network-interfaces-1.0' do
  title 'Test a plural resource of the aws ec2 network interfaces.'

  describe aws_ec2_network_interfaces do
    it { should exist }
  end

  describe aws_ec2_network_interfaces do
    its('associations') { should_not be_empty }
    its('attachments') { should_not be_empty }
    its('availability_zones') { should include 'us-east-2a' }
    its('groups') { should_not be_empty }
    its('ipv_6_addresses') { should_not be_empty }
  end
end
