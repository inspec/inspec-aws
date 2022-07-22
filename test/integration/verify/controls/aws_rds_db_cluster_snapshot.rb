aws_db_cluster_snapshot_id = input(:aws_db_cluster_snapshot_id, value: '', description: '')
aws_db_cluster_snapshot_status = input(:aws_db_cluster_snapshot_status, value: '', description: '')
aws_db_cluster_snapshot_engine = input(:aws_db_cluster_snapshot_engine, value: '', description: '')
aws_db_cluster_snapshot_engine_version = input(:aws_db_cluster_snapshot_engine_version, value: '', description: '')
aws_db_cluster_snapshot_db_cluster_identifier = input(:aws_db_cluster_snapshot_db_cluster_identifier, value: '', description: '')
aws_db_cluster_snapshot_db_cluster_snapshot_arn = input(:aws_db_cluster_snapshot_db_cluster_snapshot_arn, value: '', description: '')
aws_db_cluster_snapshot_vpc_id = input(:aws_db_cluster_snapshot_vpc_id, value: '', description: '')
aws_db_cluster_snapshot_storage_encrypted = input(:aws_db_cluster_snapshot_storage_encrypted, value: '', description: '')
aws_db_cluster_snapshot_source_db_cluster_snapshot_arn = input(:aws_db_cluster_snapshot_source_db_cluster_snapshot_arn, value: '', description: '')

control 'aws-rds-db-cluster-snapshot-1.0' do
  impact 1.0
  title 'Test the properties of the rds db cluster snapshot.'

  describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: aws_db_cluster_snapshot_id ) do
    it { should exist }
  end

  describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: aws_db_cluster_snapshot_id ) do
    its('db_cluster_snapshot_identifier') { should eq aws_db_cluster_snapshot_id }
    its('db_cluster_identifier') { should eq aws_db_cluster_snapshot_db_cluster_identifier }
    its('engine') { should eq aws_db_cluster_snapshot_engine }
    its('engine_mode') { should eq 'provisioned' }
    its('allocated_storage') { should eq 0 }
    its('status') { should eq aws_db_cluster_snapshot_status }
    its('port') { should eq 0 }
    its('vpc_id') { should eq aws_db_cluster_snapshot_vpc_id }
    its('master_username') { should eq 'postgres' }
    its('engine_version') { should eq aws_db_cluster_snapshot_engine_version }
    its('license_model') { should eq 'aurora-mysql' }
    its('snapshot_type') { should eq 'manual' }
    its('percent_progress') { should eq 100 }
    its('storage_encrypted') { should eq true }
    its('db_cluster_snapshot_arn') { should eq aws_db_cluster_snapshot_db_cluster_snapshot_arn }
    its('aws_db_cluster_snapshot_source_db_cluster_snapshot_arn') { should aws_db_cluster_snapshot_source_db_cluster_snapshot_arn }
    its('aws_db_cluster_snapshot_storage_encrypted') { should eq aws_db_cluster_snapshot_storage_encrypted }
    its('tag_list') { should_not be_empty }
  end

  describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: 'dummy' ) do
    it { should_not exist }
  end
end
