network_acl_id = input(:network_acl_id, value: '', description: 'The ID of the network ACL.')
subnet_id = input(:aws_subnet_id, value: '', description: 'The ID of the subnet involved in the association.')
acl_cidr_block = input(:aws_network_acl_cidr_block, value: '', description: 'The IPv4 CIDR range specified in the entry.')
vpc_id = input(:aws_vpc_id, value: '', description: 'The ID of the VPC for the network ACL.')
egress_rule_number = input(:acl_egress_rule_number, value: '', description: 'The rule number of the egress (applied to traffic leaving the subnet)')
ingress_rule_number = input(:acl_ingress_rule_number, value: '', description: 'The rule number of the ingress (applied to traffic coming into the subnet)')

title 'Test multiple AWS Network ACLs'

control 'aws-network-ACLs-1.0' do
  title 'Check AWS Network ACLs have the correct properties.'

  describe aws_network_acls.where { entries_cidr_blocks.include?(acl_cidr_block) } do
    it { should exist }
    its('vpc_ids') { should include vpc_id }
    its('default_network_acl_ids') { should be_empty }
    its('associated_subnet_ids') { should include subnet_id }

    its('entries_port_ranges') { should include 80 }
    its('entries_protocols') { should include '-1' }
    its('entries_rule_actions') { should include 'allow' }
    its('entries_rule_actions') { should include 'deny' }
    its('egress_rule_numbers') { should include egress_rule_number }
    its('ingress_rule_numbers') { should include ingress_rule_number }
  end

  describe aws_network_acls.where { entries_rule_numbers.include?(ingress_rule_number) } do
    it { should exist }
  end
end
