aws_parameter_group_name = attribute("aws_parameter_group_name", default: "", description: "The name of a specific parameter group for which to return details. By default, details about all parameter groups and the default parameter group are returned.")
aws_parameter_group_family = attribute("aws_parameter_group_family", default: "", description: "The family of the parameter group.")
aws_description = attribute("aws_description", default: "", description: "The description of the parameter group.")
aws_tags = attribute("aws_tags", default: "", description: "The tags of the parameter group.")

control 'aws-redshift-parameter-groups-1.0' do
    impact 1.0
    title 'Ensure AWS Redshift Parameter Group plural resouce has the correct properties.'
    describe aws_redshift_cluster_parameter_groups do
      it { should exist }
      its('parameter_group_names') { should include aws_parameter_group_name }
      its('parameter_group_families') { should include aws_parameter_group_family }
      its('descriptions') { should include aws_description }
      its('tags') { should_not be_empty }
    end
  end
  