title 'Test a single AWS RDS Parameter Group'

aws_rds_db_parameter_group_name     = attribute(:aws_rds_db_parameter_group_name, default: 'soumyotest', description: 'The name of the DB parameter group.')
aws_rds_db_parameter_group_family   = attribute(:aws_rds_db_parameter_group_family, default: 'aurora-mysql5.7', description: 'The name of the DB parameter group family that this DB parameter group is compatible with.')
aws_rds_description                 = attribute(:aws_rds_description, default: 'Soumyotest', description: 'Provides the customer-specified description for this DB parameter group.')
aws_rds_db_parameter_group_arn      = attribute(:aws_rds_db_parameter_group_arn, default: 'arn:aws:rds:eu-west-1:112758395563:pg:soumyotest', description: 'The Amazon Resource Name (ARN) for the DB parameter group.')

control 'aws-db-parameter-group-1.0' do

  impact 1.0
  title 'Ensure AWS RDS Parameter Group has current properties'

  describe aws_db_parameter_group(db_parameter_group_name: aws_rds_db_parameter_group_name) do
     
    it { should exist }
  end

  describe aws_db_parameter_group(db_parameter_group_name: aws_rds_db_parameter_group_name) do
    its('db_parameter_group_name')        { should eq aws_rds_db_parameter_group_name }
    its('db_parameter_group_family')      { should eq aws_rds_db_parameter_group_family }
    its('description')                    { should eq aws_rds_description }
    its('db_parameter_group_arn')         { should eq aws_rds_db_parameter_group_arn }
  end

  describe aws_db_parameter_group(db_parameter_group_name: "wrongvalue") do
    it { should_not exist }
  end

end
