title 'Test AWS Security Groups in bulk'

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

    end
  end

end
