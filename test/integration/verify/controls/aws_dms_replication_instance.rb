control 'aws-dms-replication-instance-1.0' do
  title 'Ensure AWS DMS Replication Instance has the correct properties.'

  describe aws_dms_replication_instance do
    it { should exist }
  end

  describe aws_dms_replication_instance do
    its('engine_version') { should eq '3.4.4' }
    its('replication_instance_class') { should eq 'dms.c4.2xlarge' }
    its('storage_type') { should eq 'gp2' }
    its('min_allocated_storage') { should eq 5 }
    its('max_allocated_storage') { should eq 6144 }
    its('default_allocated_storage') { should eq 100 }
    its('included_allocated_storage') { should eq 100 }
    its('availability_zones') { should eq ['us-east-2a', 'us-east-2b', 'us-east-2c'] }
    its('release_status') { should be_empty }
  end
end
