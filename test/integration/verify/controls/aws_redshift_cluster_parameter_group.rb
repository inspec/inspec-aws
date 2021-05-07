aws_parameter_group_name = attribute("aws_parameter_group_name", default: "", description: "The name of a specific parameter group for which to return details. By default, details about all parameter groups and the default parameter group are returned.")
aws_parameter_group_family = attribute("aws_parameter_group_family", default: "", description: "The family of the parameter group.")
aws_description = attribute("aws_description", default: "", description: "The description of the parameter group.")
aws_tags = attribute("aws_tags", default: "", description: "The tags of the parameter group.")

control 'aws-redshift-parameter-group-1.0' do
  impact 1.0
  title 'Ensure AWS Redshift Parameter Group singular resouce has the correct properties.'
  describe aws_redshift_cluster_parameter_group(parameter_group_name: aws_parameter_group_name) do
    it { should exist }
    its('parameter_group_name') { should eq aws_parameter_group_name }
    its('parameter_group_family') { should eq aws_parameter_group_family }
    its('description') { should eq aws_description }
    its('tags') { should be_empty }
  end
end