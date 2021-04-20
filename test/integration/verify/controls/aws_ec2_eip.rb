aws_public_ip = attribute("aws_public_ip", default: "", description: "The Elastic IP address, or the carrier IP address.")
aws_instance_id1 = attribute("aws_instance_id", default: "", description: "The ID of the instance the address is associated with, if any.")
aws_allocation_id = attribute("aws_allocation_id", default: "", description: "The allocation ID for the address.")
aws_association_id = attribute("aws_association_id", default: "", description: "The association ID for the address.")
aws_domain = attribute("aws_domain", default: "vpc", description: "Indicates whether the address is for use in EC2-Classic (standard) or in a VPC (vpc).")
aws_network_interface_id = attribute("aws_network_interface_id", default: "", description: "The ID of the network interface that the address is associated with, if any.")
aws_network_interface_owner_id = attribute("aws_network_interface_owner_id", default: "", description: "The AWS account ID of the owner.")
aws_private_ip_address = attribute("aws_private_ip_address", default: "", description: "The private IP address associated with the Elastic IP address.")
aws_public_ipv_4_pool = attribute("aws_public_ipv_4_pool", default: "", description: "The Elastic IPV4 pool address.")
aws_network_border_group = attribute("aws_network_border_group", default: "", description: "A unique set of Availability Zones, Local Zones, or Wavelength Zones from where AWS advertises IP addresses.")

control 'aws-ec2-elasticip' do
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
    its('public_ipv_4_pool') { should eq aws_public_ipv_4_pool }
    its('network_border_group') { should eq aws_network_border_group }
  end

  describe aws_ec2_eip(public_ip: "1.1.1.1") do
    it { should_not exist }
  end
end