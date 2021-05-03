title 'Test AWS RDS Parameter Groups in bulk'

aws_rds_db_parameter_group_family   = attribute(:aws_rds_db_parameter_group_family, default: 'aurora-mysql5.7', description: 'The name of the DB parameter group family that this DB parameter group is compatible with.')
aws_rds_db_parameter_group_arn      = attribute(:aws_rds_db_parameter_group_arn, default: 'arn:aws:rds:eu-west-1:112758395563:pg:soumyotest', description: 'The Amazon Resource Name (ARN) for the DB parameter group.')

control 'aws-db-parameter-groups-loop-1.0' do

  impact 1.0
  title 'Loop across AWS RDS Parameter Group resource using singular resource for detail.'

  aws_db_parameter_groups.db_parameter_group_names.each do |parameter_group|
    describe aws_db_parameter_group(db_parameter_group_name: parameter_group) do
      it { should exist }
    end
  end

  aws_db_parameter_groups.where { db_parameter_group_family == aws_rds_db_parameter_group_family }.db_parameter_group_names.each do |parameter_group|
    describe aws_db_parameter_group(db_parameter_group_name: parameter_group) do
      it { should exist }
      its('db_parameter_group_family')      { should include aws_rds_db_parameter_group_family }
      its('db_parameter_group_arn')         { should eq aws_rds_db_parameter_group_arn }
    end
  end
end
