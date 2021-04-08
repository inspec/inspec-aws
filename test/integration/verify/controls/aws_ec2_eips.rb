aws_public_ip = attribute("aws_public_ip", default: "", description: "The Elastic IP address, or the carrier IP address.")
aws_instance_id = attribute("aws_instance_id", default: "", description: "The ID of the instance the address is associated with, if any.")
aws_allocation_id = attribute("aws_allocation_id", default: "", description: "The allocation ID for the address.")
aws_association_id = attribute("aws_association_id", default: "", description: "The association ID for the address.")
aws_domain = attribute("aws_domain", default: "vpc", description: "Indicates whether the address is for use in EC2-Classic (standard) or in a VPC (vpc).")
aws_network_interface_id = attribute("aws_network_interface_id", default: "", description: "The ID of the network interface that the address is associated with, if any.")
aws_network_interface_owner_id = attribute("aws_network_interface_owner_id", default: "", description: "The AWS account ID of the owner.")
aws_private_ip_address = attribute("aws_private_ip_address", default: "", description: "The private IP address associated with the Elastic IP address.")
aws_public_ipv_4_pool = attribute("aws_public_ipv_4_pool", default: "", description: "The Elastic IPV4 pool address.")
aws_network_border_group = attribute("aws_network_border_group", default: "", description: "A unique set of Availability Zones, Local Zones, or Wavelength Zones from where AWS advertises IP addresses.")

control 'aws-ec2-elasticips' do
    impact 1.0
    title 'Specifies an Elastic IP (EIP) address and can, optionally, associate it with an Amazon EC2 instance.'
  
    describe aws_ec2_eips do
        it { should exist }
    end
    describe aws_ec2_eips do
        its('count')                        { should be <= 100 }
    end
    describe aws_ec2_eips do
        its('count')                        { should be <= 100 }
        its('instance_ids')                 { should include aws_instance_id }
        its('public_ips')                   { should include aws_public_ip }
        its('allocation_ids')               { should include aws_allocation_id }
        its('association_ids')              { should include aws_association_id }
        its('domains')                      { should include aws_domain }
        its('network_interface_ids')        { should include aws_network_interface_id }
        its('network_interface_owner_ids')  { should include aws_network_interface_owner_id }
        its('private_ip_addresss')          { should include aws_private_ip_address }
        its('public_ipv_4_pools')           { should include aws_public_ipv_4_pool }
        its('network_border_groups')        { should include aws_network_border_group }
    end
    describe aws_ec2_eips do
        its('instance_ids')                 { should include "i-" }
    end
end