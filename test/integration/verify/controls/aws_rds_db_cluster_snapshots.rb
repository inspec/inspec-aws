aws_db_cluster_snapshot_id = input(:aws_db_cluster_snapshot_id, value: '', description: '')
aws_db_cluster_snapshot_status = input(:aws_db_cluster_snapshot_status, value: '', description: '')
aws_db_cluster_snapshot_engine = input(:aws_db_cluster_snapshot_engine, value: '', description: '')
aws_db_cluster_snapshot_engine_version = input(:aws_db_cluster_snapshot_engine_version, value: '', description: '')
aws_db_cluster_snapshot_db_cluster_identifier = input(:aws_db_cluster_snapshot_db_cluster_identifier, value: '', description: '')
aws_db_cluster_snapshot_db_cluster_snapshot_arn = input(:aws_db_cluster_snapshot_db_cluster_snapshot_arn, value: '', description: '')
aws_db_cluster_snapshot_vpc_id = input(:aws_db_cluster_snapshot_vpc_id, value: '', description: '')
aws_db_cluster_snapshot_storage_encrypted = input(:aws_db_cluster_snapshot_storage_encrypted, value: '', description: '')

control 'aws-rds-db-cluster-snapshots-1.0' do
  impact 1.0
  title 'Test the properties of the rds db cluster snapshots.'

  describe aws_rds_db_cluster_snapshots do
    it { should exist }
  end

  describe aws_rds_db_cluster_snapshots do
    its('db_cluster_snapshot_identifiers') { should include aws_db_cluster_snapshot_id }
    its('db_cluster_identifiers') { should include aws_db_cluster_snapshot_db_cluster_identifier }
    its('engines') { should include aws_db_cluster_snapshot_engine }
    its('engine_modes') { should include 'provisioned' }
    its('allocated_storages') { should include 0 }
    its('statuses') { should include aws_db_cluster_snapshot_status }
    its('ports') { should include 0 }
    its('vpc_ids') { should include aws_db_cluster_snapshot_vpc_id }
    its('engine_versions') { should include aws_db_cluster_snapshot_engine_version }
    its('license_models') { should include 'aurora-mysql' }
    its('snapshot_types') { should include 'manual' }
    its('percent_progresses') { should include 100 }
    its('storage_encrypted') { should include true }
    its('db_cluster_snapshot_arns') { should include aws_db_cluster_snapshot_db_cluster_snapshot_arn }
    its('source_db_cluster_snapshot_arns') { should_not be_empty }
    its('storage_encrypted') { should include aws_db_cluster_snapshot_storage_encrypted }
    its('tag_lists') { should_not be_empty }
  end
end
