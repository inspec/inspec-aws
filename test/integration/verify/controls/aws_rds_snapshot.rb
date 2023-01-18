aws_rds_snapshot_identifier = input(:aws_rds_snapshot_identifier, value: '', description: 'The AWS RDS snapshot identifier.')
aws_rds_snapshot_engine = input(:aws_rds_snapshot_engine, value: '', description: 'The AWS RDS snapshot engine.')
aws_rds_snapshot_engine_version = input(:aws_rds_snapshot_engine_version, value: '', description: 'The AWS RDS snapshot engine version.')
aws_rds_snapshot_storage_type = input(:aws_rds_snapshot_storage_type, value: '', description: 'The AWS RDS snapshot storage type.')

title 'Test single AWS RDS Snapshot'

control 'aws-rds-snapshot-1.0' do
  title 'Ensure AWS RDS Snapshot has the correct properties.'

  describe aws_rds_snapshot(db_snapshot_identifier: aws_rds_snapshot_identifier) do
    it { should exist }
    it { should have_encrypted_snapshot }
    its ('encrypted') { should eq true }
    its ('engine') { should eq aws_rds_snapshot_engine }
    its ('engine_version') { should eq aws_rds_snapshot_engine_version }
    its ('storage_type') { should eq aws_rds_snapshot_storage_type }
    its ('allocated_storage') { should eq 10 }
  end

  describe aws_rds_snapshot(aws_rds_snapshot_identifier) do
    it { should exist }
  end

  describe aws_rds_snapshot('not-there') do
    it { should_not exist }
  end
end
