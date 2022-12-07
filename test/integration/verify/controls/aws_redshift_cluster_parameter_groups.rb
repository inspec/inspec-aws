aws_parameter_group_name = input(:aws_redshift_parameter_group_name, value: '', description: 'The name of a specific parameter group for which to return details. By default, details about all parameter groups and the default parameter group are returned.')
aws_parameter_group_family = input(:aws_redshift_parameter_group_family, value: '', description: 'The family of the parameter group.')

control 'aws-redshift-parameter-groups-1.0' do
  impact 1.0
  title 'Ensure AWS Redshift Parameter Group plural resource has the correct properties.'
  
  describe aws_redshift_cluster_parameter_groups do
    it { should exist }
    its('parameter_group_names') { should include aws_parameter_group_name }
    its('parameter_group_families') { should include aws_parameter_group_family }
    its('descriptions') { should include "Managed by Terraform" }
    its('tags') { should_not be_empty }
  end
end
