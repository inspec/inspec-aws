aws_rds_db_identifier = input(:aws_rds_db_identifier, value: '', description: 'The AWS RDS DB identifier.')
aws_rds_db_name = input(:aws_rds_db_name, value: '', description: 'The AWS RDS DB name.')
aws_rds_db_engine = input(:aws_rds_db_engine, value: '', description: 'The AWS RDS DB engine.')
aws_rds_db_engine_version = input(:aws_rds_db_engine_version, value: '', description: 'The AWS RDS DB engine version.')
aws_rds_db_storage_type = input(:aws_rds_db_storage_type, value: '', description: 'The AWS RDS DB storage type.')
aws_rds_db_master_user = input(:aws_rds_db_master_user, value: '', description: 'The AWS RDS DB username.')

title 'Test single AWS RDS Instance'

control 'aws-rds-instance-1.0' do
  impact 1.0
  title 'Ensure AWS RDS Instance has the correct properties.'

  describe aws_rds_instance(aws_rds_db_identifier) do
    it { should exist }
  end

  describe aws_rds_instance(db_instance_identifier: aws_rds_db_identifier) do
    it { should exist }
    it { should have_encrypted_storage }
    its ('storage_encrypted') { should eq true }
    its ('db_name') { should eq aws_rds_db_name }
    its ('engine') { should eq aws_rds_db_engine }
    its ('engine_version') { should eq aws_rds_db_engine_version }
    its ('storage_type') { should eq aws_rds_db_storage_type }
    its ('master_username') { should eq aws_rds_db_master_user }
    its ('allocated_storage') { should eq 10 }
    its ('db_instance_class') { should eq 'db.t3.small' }
    its ('tags') { should include('Name' => aws_rds_db_name)}
  end

  describe aws_rds_instance('not-there') do
    it { should_not exist }
  end
end
