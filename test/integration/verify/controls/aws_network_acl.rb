network_acl_id = input(:network_acl_id, value: '', description: 'The ID of the network ACL.')
subnet_id = input(:aws_subnet_id, value: '', description: 'The ID of the subnet involved in the association.')
acl_cidr_block = input(:aws_network_acl_cidr_block, value: '', description: 'The IPv4 CIDR range specified in the entry.')
vpc_id = input(:input, value: '', description: 'The ID of the VPC for the network ACL.')

title 'Test single AWS Network ACL'

control 'aws-network-acl-1.0' do
  impact 1.0
  title 'Check AWS Network ACL has the correct properties.'

  describe aws_network_acl(network_acl_id: network_acl_id) do
    it { should exist }
  end

  describe aws_network_acl(network_acl_id: network_acl_id) do
    it { should_not be_default }
    it { should be_associated }
    it { should have_associations(subnet_id: subnet_id) }
    it { should have_acl_entry_value(cidr_block: acl_cidr_block, egress: false, rule_action: 'allow') }
    it { should have_egress }
    it { should have_egress(cidr_block: acl_cidr_block, rule_action: 'allow') }
    it { should have_ingress }

    its('vpc_id') { should eq vpc_id }
    its('associated_subnet_ids') { should include subnet_id }
    its('egress_rule_number_100.cidr_block') { should eq acl_cidr_block }
    its('egress_rule_number_100.protocol') { should eq '6' }
    its('egress_rule_number_100.rule_action') { should eq 'allow' }
    its('egress_rule_number_100.rule_number') { should eq 100 }
    its('egress_rule_number_100.port_range.from') { should eq 443 }
    its('egress_rule_number_100.port_range.to') { should eq 443 }
  end
end
