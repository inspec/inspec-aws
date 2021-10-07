describe aws_rds_db_snapshot(db_cluster_snapshot_id: 'automate-pg-test-instance-1-final-snapshot') do
  it { should exist }
  its('availability_zones') { should include 'us-east-2a' }
  its('db_cluster_snapshot_identifier') { should eq 'automate-pg-test-instance-1-final-snapshot' }
  its('db_cluster_identifier') { should eq 'automate-pg-test' }
  its('snapshot_create_time') { should eq Time.parse('2021-01-22 06:44:35.473000000 +0000') }
  its('engine') { should eq 'aurora-postgresql' }
  its('engine_mode') { should eq 'provisioned' }
  its('allocated_storage') { should eq 0 }
  its('status') { should eq 'available' }
  its('port') { should eq 0 }
  its('vpc_id') { should eq 'vpc-6d9d7505' }
  its('cluster_create_time') { should eq Time.parse('2020-12-17 12:32:55.293000000 +0000') }
  its('master_username') { should eq 'postgres' }
  its('engine_version') { should eq '11.7' }
  its('license_model') { should eq 'postgresql-license' }
  its('snapshot_type') { should eq 'manual' }
  its('percent_progress') { should eq 100 }
  its('storage_encrypted') { should eq true }
  its('kms_key_id') { should eq 'arn:aws:kms:us-east-2:112758395563:key/548fb7d5-8e2f-433b-9005-2ed0ee4a2ee0' }
  its('db_cluster_snapshot_arn') { should eq 'arn:aws:rds:us-east-2:112758395563:cluster-snapshot:automate-pg-test-instance-1-final-snapshot' }
  its('source_db_cluster_snapshot_arn') { should be_empty }
  its('iam_database_authentication_enabled') { should eq false }
  its('tag_list') { should_not be_empty }
end