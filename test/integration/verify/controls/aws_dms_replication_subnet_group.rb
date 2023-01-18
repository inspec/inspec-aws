control 'aws-dms-replication-subnet-group-1.0' do
  title 'Ensure AWS DMS Replication Subnet Group has the correct properties.'

  describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'test1') do
    it { should exist}
  end

  describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'test1') do
    its('replication_subnet_group_identifier') { should eq 'test1'}
    its('replication_subnet_group_description') { should eq 'test1'}
    its('vpc_id') { should eq 'vpc-08b86815ee2c22d53'}
    its('subnet_group_status') { should eq 'Complete'}
    its('subnets.first.subnet_identifier') { should eq 'subnet-0e24f62a817862246'}
    its('subnets.first.subnet_availability_zone.name') { should eq 'us-east-2b'}
    its('subnets.first.subnet_status') { should eq 'Active'}
  end
end
