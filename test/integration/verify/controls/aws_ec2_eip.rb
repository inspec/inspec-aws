aws_public_ip = input(:aws_public_ip, value: '', description: 'The Elastic IP address, or the carrier IP address.')
aws_instance_id1 = input(:aws_instance_id1, value: '', description: 'The ID of the instance the address is associated with, if any.')
aws_allocation_id = input(:aws_allocation_id, value: '', description: 'The allocation ID for the address.')
aws_association_id = input(:aws_association_id, value: '', description: 'The association ID for the address.')
aws_domain = input(:aws_domain, value: 'vpc', description: 'Indicates whether the address is for use in EC2-Classic (standard) or in a VPC (vpc).')
aws_network_interface_id = input(:aws_network_interface_id, value: '', description: 'The ID of the network interface that the address is associated with, if any.')
aws_network_interface_owner_id = input(:aws_network_interface_owner_id, value: '', description: 'The AWS account ID of the owner.')
aws_private_ip_address = input(:aws_private_ip_address, value: '', description: 'The private IP address associated with the Elastic IP address.')

control 'aws-ec2-elastic-ip-1.0' do

  impact 1.0
  title 'Specifies an Elastic IP (EIP) address and can, optionally, associate it with an Amazon EC2 instance.'

  describe aws_ec2_eip(public_ip: aws_public_ip) do
    it { should exist }
  end

  describe aws_ec2_eip(public_ip: aws_public_ip) do
    it { should exist }
    its('instance_id') { should eq aws_instance_id1 }
    its('public_ip') { should eq aws_public_ip }
    its('allocation_id') { should eq aws_allocation_id }
    its('association_id') { should eq aws_association_id }
    its('domain') { should eq aws_domain }
    its('network_interface_id') { should eq aws_network_interface_id }
    its('network_interface_owner_id') { should eq aws_network_interface_owner_id }
    its('private_ip_address') { should eq aws_private_ip_address }
  end

  describe aws_ec2_eip(public_ip: '1.1.1.1') do
    it { should_not exist }
  end
end
