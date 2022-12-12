title 'Test AWS RDS Parameter Groups in bulk'

aws_db_parameter_group_name = input(:aws_db_parameter_group_name, value: '', description: 'The name of the DB parameter group.')
aws_db_parameter_group_family_name = input(:aws_db_parameter_group_family_name, value: '', description: 'The name of the DB parameter group family that this DB parameter group is compatible with.')
aws_db_parameter_group_arn = input(:aws_db_parameter_group_arn, value: '', description: 'The Amazon Resource Name (ARN) for the DB parameter group.')

control 'aws-db-parameter-groups-1.0' do
  title 'Ensure AWS RDS Parameter groups has current properties'

  describe aws_db_parameter_groups do
    it { should exist }
    its('db_parameter_group_names') { should include(aws_db_parameter_group_name) }
    its('db_parameter_group_families') { should include(aws_db_parameter_group_family_name) }
    its('db_parameter_group_arns') { should include(aws_db_parameter_group_arn) }
  end

  describe aws_db_parameter_groups.where(db_parameter_group_family: aws_db_parameter_group_family_name) do
    it { should exist }
    its('db_parameter_group_names') { should include(aws_db_parameter_group_name) }
    its('db_parameter_group_families') { should include(aws_db_parameter_group_family_name) }
    its('db_parameter_group_arns') { should include(aws_db_parameter_group_arn) }
  end
end
