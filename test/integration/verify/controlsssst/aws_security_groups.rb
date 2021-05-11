title 'Test AWS Security Groups in bulk'

aws_default_vpc_id = attribute(:aws_default_vpc_id, default: '', description: 'The AWS region default Security Group ID.')
aws_vpc_id = attribute(:aws_vpc_id, default: '', description: 'The AWS Security Group ID.')
aws_security_group_default_id = attribute(:aws_security_group_default_id, default: '', description: 'AWS Security Group ID.')
aws_security_group_alpha_id = attribute(:aws_security_group_alpha_id, default: '', description: 'AWS Security Group ID.')
aws_security_group_alpha = attribute(:aws_security_group_alpha, default: '', description: 'AWS Security Group name.')
aws_security_group_beta_id = attribute(:aws_security_group_beta_id, default: '', description: 'AWS Security Group ID.')
aws_security_group_beta = attribute(:aws_security_group_beta, default: '', description: 'AWS Security Group name.')
aws_security_group_gamma_id = attribute(:aws_security_group_gamma_id, default: '', description: 'AWS Security Group ID.')
aws_security_group_gamma = attribute(:aws_security_group_gamma, default: '', description: 'AWS Security Group name.')
aws_security_group_omega_id = attribute(:aws_security_group_omega_id, default: '', description: 'AWS Security Group ID.')
aws_security_group_omega = attribute(:aws_security_group_omega, default: '', description: 'AWS Security Group name.')

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

end