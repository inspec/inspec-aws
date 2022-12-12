title 'Test single AWS Security Group'

aws_security_group_zeta_id = input(:aws_security_group_zeta_id, value: '', description: 'AWS Security Group ID.')
aws_security_group_zeta = input(:aws_security_group_zeta, value: '', description: 'AWS Security Group name.')
aws_default_vpc_id = input(:aws_default_vpc_id, value: '', description: 'The AWS region default Security Group ID.')
aws_vpc_id = input(:aws_vpc_id, value: '', description: 'The AWS Security Group ID.')
aws_security_group_default_id = input(:aws_security_group_default_id, value: '', description: 'AWS Security Group ID.')
aws_security_group_alpha_id = input(:aws_security_group_alpha_id, value: '', description: 'AWS Security Group ID.')
aws_security_group_alpha = input(:aws_security_group_alpha, value: '', description: 'AWS Security Group name.')
aws_security_group_beta_id = input(:aws_security_group_beta_id, value: '', description: 'AWS Security Group ID.')
aws_security_group_beta = input(:aws_security_group_beta, value: '', description: 'AWS Security Group name.')
aws_security_group_gamma_id = input(:aws_security_group_gamma_id, value: '', description: 'AWS Security Group ID.')
aws_security_group_gamma = input(:aws_security_group_gamma, value: '', description: 'AWS Security Group name.')
aws_security_group_omega_id = input(:aws_security_group_omega_id, value: '', description: 'AWS Security Group ID.')
aws_security_group_omega = input(:aws_security_group_omega, value: '', description: 'AWS Security Group name.')

control 'aws-security-group-1.0' do
  title 'Ensure AWS Security Group has the correct properties.'

  describe aws_security_group(aws_security_group_default_id) do
    it { should exist }
  end

  describe aws_security_group(id: aws_security_group_default_id) do
    it { should exist }
  end

  describe aws_security_group(group_id: aws_security_group_default_id) do
    it { should exist }
    its('group_id') { should eq aws_security_group_default_id }
  end

  describe aws_security_group(group_name: 'default', vpc_id: aws_default_vpc_id) do
    it { should exist }
  end

  describe aws_security_group(group_name: 'no-such-security-group') do
    it { should_not exist }
  end

  describe aws_security_group(aws_security_group_omega_id) do
    it { should exist }
    its('vpc_id') { should eq aws_vpc_id }
    its('group_name') { should eq aws_security_group_omega }
    its('description') { should cmp 'SG omega' }
    its('inbound_rules.count') { should be_zero }
    its('outbound_rules.count') { should be_zero }
  end

  describe aws_security_group(aws_security_group_alpha_id) do
    it { should exist }
    its('vpc_id') { should eq aws_default_vpc_id }
    its('group_name') { should eq aws_security_group_alpha }
    its('vpc_id') { should eq aws_default_vpc_id }
    its('description') { should cmp 'SG alpha' }
    its('inbound_rules') { should be_a_kind_of(Array) }
    its('inbound_rules.first') { should be_a_kind_of(Hash) }
    its('inbound_rules.count') { should cmp 3 } # 3 explicit, one implicit
    its('inbound_rules_count') { should cmp 4 }
    its('outbound_rules') { should be_a_kind_of(Array) }
    its('outbound_rules.first') { should be_a_kind_of(Hash) }
    its('outbound_rules.count') { should cmp 1 } # 1 explicit
    its('outbound_rules_count') { should cmp 3 } # 3 CIDR blocks specified
    its('tags') { should include('Environment' => 'Dev',
                                 'Name' => aws_security_group_alpha)}
    it { should allow_in(port: 22) }
    it { should_not allow_in(port: 631, ipv4_range: '0.0.0.0/0') }
    it { should allow_in(ipv4_range: '0.0.0.0/0', port: 80) }
    it { should_not allow_in(ipv4_range: '0.0.0.0/0', port: 22) }
    it { should allow_in(ipv4_range: '10.1.2.0/24', port: 22) }
    it { should allow_in(ipv4_range: ['10.1.2.0/24'], port: 22) }
    it { should allow_in(ipv6_range: ['2001:db8::/122'], port: 22) }
    it { should allow_in({ ipv4_range: '10.1.2.32/32', position: 2 }) }
    it { should_not allow_in_only({ ipv4_range: '10.1.2.32/32', position: 2 }) }
    it { should allow_in_only({ ipv4_range: '10.1.2.0/24', position: 2 }) }
    # Fixture allows out 6000-6007, with one rule
    it { should allow_out(port: 6003) }
    it { should_not allow_out_only(port: 6003) }
    it { should allow_out_only(from_port: 6000, to_port: 6007) }
    it { should allow_out(ipv4_range: ['10.1.2.0/24', '10.3.2.0/24']) }
    it { should allow_out(ipv4_range: ['10.1.2.0/24', '10.3.2.0/24'], from_port: 6000, to_port: 6007) }
    it { should allow_out(ipv4_range: ['10.1.2.0/24', '10.3.2.0/24'], from_port: 6000, to_port: 6007, position: 1) }
    it { should allow_out(ipv6_range: ['2001:db8::/122']) }
    it { should allow_out(ipv6_range: ['2001:db8::/122'], from_port: 6000, to_port: 6007) }
  end

  describe aws_security_group(aws_security_group_beta_id) do
    it { should allow_in(port: 22, security_group: aws_security_group_alpha_id) }
    it { should allow_in(security_group: aws_security_group_gamma_id) }
    its('group_name') { should eq aws_security_group_beta }
  end

  describe aws_security_group(aws_security_group_gamma_id) do
    it { should allow_in_only(port: 22, security_group: aws_security_group_alpha_id) }
    its('group_name') { should eq aws_security_group_gamma }
  end

  describe aws_security_group(aws_security_group_zeta_id) do
    its('group_name') { should eq aws_security_group_zeta }
    it { should allow_in(ipv4_range: '0.0.0.0/0', protocol: 'any') }
    it { should allow_in(ipv4_range: '0.0.0.0/0', protocol: 'all') }
    it { should allow_out(ipv4_range: '0.0.0.0/0', protocol: 'any') }
    it { should allow_out(ipv4_range: '0.0.0.0/0', protocol: 'all') }
  end
end
