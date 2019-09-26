title 'Test single AWS VPC'

aws_rds_db_identifier = input(:aws_rds_db_identifier, value: '', description: 'The AWS RDS DB identifier.')
aws_rds_db_name = input(:aws_rds_db_name, value: '', description: 'The AWS RDS DB name.')
aws_rds_db_engine = input(:aws_rds_db_engine, value: '', description: 'The AWS RDS DB engine.')
aws_rds_db_engine_version = input(:aws_rds_db_engine_version, value: '', description: 'The AWS RDS DB engine version.')
aws_rds_db_storage_type = input(:aws_rds_db_storage_type, value: '', description: 'The AWS RDS DB storage type.')
aws_rds_db_master_user = input(:aws_rds_db_master_user, value: '', description: 'The AWS RDS DB username.')


control 'aws-rds-instances-1.0' do

  impact 1.0
  title 'Ensure AWS RDS Instances has the correct properties.'

  describe aws_rds_instances do
    it { should exist }
  end

  aws_rds_instances.db_instance_identifiers.each do |db_instance_identifier|
    describe aws_rds_instance(db_instance_identifier) do
      it { should have_encrypted_storage }
      it { should be_encrypted }
    end
  end
end
