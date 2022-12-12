title 'Test AWS RDS Subnet Groups in bulk'

aws_rds_db_subnet_group_vpc_id = input(:aws_rds_db_subnet_group_vpc_id, value: '', description: 'The VPC id for DB Subnet Group.')
aws_rds_db_subnet_group_arn = input(:aws_rds_db_subnet_group_arn, value: '', description: 'The ARN for DB Subnet Group.')

control 'aws-db-subnet-groups-loop-1.0' do
  title 'Loop across AWS RDS Subnet Group resource using singular resource for detail.'

  aws_db_subnet_groups.db_subnet_group_names.each do |subnet_group|
    describe aws_db_subnet_group(db_subnet_group_name: subnet_group) do
      it { should exist }
    end
  end

  aws_db_subnet_groups.where { vpc_id == aws_rds_db_subnet_group_vpc_id }.db_subnet_group_names.each do |subnet_group|
    describe aws_db_subnet_group(db_subnet_group_name: subnet_group) do
      it { should exist }
      its('vpc_id')              { should include aws_rds_db_subnet_group_vpc_id }
      its('db_subnet_group_arn') { should eq aws_rds_db_subnet_group_arn }
    end
  end
end
