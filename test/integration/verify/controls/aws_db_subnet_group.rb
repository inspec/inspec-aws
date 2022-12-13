title 'Test a single AWS RDS Subnet Group'

aws_rds_db_subnet_group_name        = input(:aws_rds_db_subnet_group_name, value: '', description: 'The AWS Subnet Group Name')
aws_rds_db_subnet_group_description = input(:aws_rds_db_subnet_group_description, value: '', description: 'The AWS Subnet Group Description')
aws_rds_db_subnet_group_vpc_id      = input(:aws_rds_db_subnet_group_vpc_id, value: '', description: 'The VPC id for DB Subnet Group.')
aws_rds_db_subnet_group_arn         = input(:aws_rds_db_subnet_group_arn, value: '', description: 'The ARN for DB Subnet Group.')

control 'aws-db-subnet-group-1.0' do

  title 'Ensure AWS RDS Subnet Group has current properties'

  describe aws_db_subnet_group(db_subnet_group_name: aws_rds_db_subnet_group_name) do
    it { should exist }
  end

  describe aws_db_subnet_group(db_subnet_group_name: aws_rds_db_subnet_group_name) do
    its('db_subnet_group_name')        { should eq aws_rds_db_subnet_group_name }
    its('db_subnet_group_description') { should eq aws_rds_db_subnet_group_description }
    its('vpc_id')                      { should eq aws_rds_db_subnet_group_vpc_id }
    its('db_subnet_group_arn')         { should eq aws_rds_db_subnet_group_arn }
  end

  describe aws_db_subnet_group(db_subnet_group_name: 'dummy') do
    it { should_not exist }
  end

end
