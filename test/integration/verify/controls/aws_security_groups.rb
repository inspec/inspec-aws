title 'Test AWS Security Groups in bulk'

aws_default_vpc_id = attribute(:aws_default_vpc_id, value: '', description: 'The AWS region default Security Group ID.')
aws_vpc_id = attribute(:aws_vpc_id, default: '', description: 'The AWS Security Group ID.')
aws_security_group_default_id = attribute(:aws_security_group_default_id, value: '', description: 'AWS Security Group ID.')
aws_security_group_alpha_id = attribute(:aws_security_group_alpha_id, value: '', description: 'AWS Security Group ID.')
aws_security_group_alpha = attribute(:aws_security_group_alpha, value: '', description: 'AWS Security Group name.')
aws_security_group_beta_id = attribute(:aws_security_group_beta_id, value: '', description: 'AWS Security Group ID.')
aws_security_group_beta = attribute(:aws_security_group_beta, value: '', description: 'AWS Security Group name.')
aws_security_group_gamma_id = attribute(:aws_security_group_gamma_id, value: '', description: 'AWS Security Group ID.')
aws_security_group_gamma = attribute(:aws_security_group_gamma, value: '', description: 'AWS Security Group name.')
aws_security_group_omega_id = attribute(:aws_security_group_omega_id, value: '', description: 'AWS Security Group ID.')
aws_security_group_omega = attribute(:aws_security_group_omega, value: '', description: 'AWS Security Group name.')

control 'aws-security-groups-1.0' do

  impact 1.0
  title 'Ensure AWS Security Groups plural resource has the correct properties.'

  describe aws_security_groups do
    it { should exist }
    its('count')       { should be >= 4 }
    its('vpc_ids')     { should include aws_vpc_id }
    its('vpc_ids')     { should include aws_default_vpc_id }
    its('group_ids')   { should include aws_security_group_default_id }
    its('group_ids')   { should include aws_security_group_alpha_id }
    its('group_ids')   { should include aws_security_group_beta_id }
    its('group_ids')   { should include aws_security_group_gamma_id }
    its('group_ids')   { should include aws_security_group_omega_id }
    its('group_names') { should include aws_security_group_alpha }
    its('group_names') { should include aws_security_group_beta }
    its('group_names') { should include aws_security_group_gamma }
    its('group_names') { should include aws_security_group_omega }
    its('tags')        { should include('Environment' => 'Dev',
                                        'Name' => aws_security_group_alpha)}
  end

  aws_security_groups.entries.each do |entry|
    describe aws_security_group(resource_data: entry) do
      it { should exist }
      its('count') { should be >= 4 }
      its('description') { should cmp 'SG alpha' }
      its('inbound_rules') { should be_a_kind_of(Array) }
      its('inbound_rules.first') { should be_a_kind_of(Hash) }
      its('inbound_rules.count') { should cmp 3 } # 3 explicit, one implicit
      its('inbound_rules_count') { should cmp 4 }
      its('outbound_rules') { should be_a_kind_of(Array) }
      its('outbound_rules.first') { should be_a_kind_of(Hash) }
      its('outbound_rules.count') { should cmp 1 } # 1 explicit
      its('outbound_rules_count') { should cmp 3 } # 3 CIDR blocks specified
    end
  end

end