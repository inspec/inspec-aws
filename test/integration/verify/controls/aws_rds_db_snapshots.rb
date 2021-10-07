describe aws_rds_db_snapshots do
  it { should exist }
  its('availability_zones') { should include ["us-east-2a", "us-east-2b", "us-east-2c"] }
  its('db_cluster_snapshot_identifiers') { should include 'automate-pg-test-instance-1-final-snapshot' }
  its('db_cluster_identifiers') { should include 'automate-pg-test' }
  its('snapshot_create_times') { should include Time.parse('2021-01-22 06:44:35.473000000 +0000') }
  its('engines') { should include 'aurora-postgresql' }
  its('engine_modes') { should include 'provisioned' }
  its('allocated_storages') { should include 0 }
  its('statuses') { should include 'available' }
  its('ports') { should include 0 }
  its('vpc_ids') { should include 'vpc-6d9d7505' }
  its('cluster_create_times') { should include Time.parse('2020-12-17 12:32:55.293000000 +0000') }
  its('master_usernames') { should include 'postgres' }
  its('engine_versions') { should include '11.7' }
  its('license_models') { should include 'postgresql-license' }
  its('snapshot_types') { should include 'manual' }
  its('percent_progresses') { should include 100 }
  its('storage_encrypted') { should_not be_empty }
  its('kms_key_ids') { should include 'arn:aws:kms:us-east-2:112758395563:key/548fb7d5-8e2f-433b-9005-2ed0ee4a2ee0' }
  its('db_cluster_snapshot_arns') { should include 'arn:aws:rds:us-east-2:112758395563:cluster-snapshot:automate-pg-test-instance-1-final-snapshot' }
  its('source_db_cluster_snapshot_arns') { should_not be_empty }
  its('iam_database_authentication_enabled') { should include false }
  its('tag_lists') { should_not be_empty }
end