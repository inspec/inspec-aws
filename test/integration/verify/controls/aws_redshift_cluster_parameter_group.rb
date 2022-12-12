aws_parameter_group_name = input(:aws_redshift_parameter_group_name, value: '', description: 'The name of a specific parameter group for which to return details. By default, details about all parameter groups and the default parameter group are returned.')
aws_parameter_group_family = input(:aws_redshift_parameter_group_family, value: '', description: 'The family of the parameter group.')

control 'aws-redshift-parameter-group-1.0' do
  title 'Ensure AWS Redshift Parameter Group singular resouce has the correct properties.'
  
  describe aws_redshift_cluster_parameter_group(parameter_group_name: aws_parameter_group_name) do
    it { should exist }
  end
  
  describe aws_redshift_cluster_parameter_group(parameter_group_name: aws_parameter_group_name) do
    its('parameter_group_name') { should eq aws_parameter_group_name }
    its('parameter_group_family') { should eq aws_parameter_group_family }
    its('description') { should eq 'Managed by Terraform' }
    its('tags') { should be_empty }
  end
  
  describe aws_redshift_cluster_parameter_group(parameter_group_name: 'dummy') do
    it { should exist }
  end
end
