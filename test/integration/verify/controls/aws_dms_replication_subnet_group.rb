control 'aws-dms-replication-subnet-group-1.0' do
  impact 1.0
  title 'Ensure AWS DMS Replication Subnet Group has the correct properties.'
  describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'test1') do
    it { should exist}
  end
end
  
control 'aws-dms-replication-subnet-group-1.0' do
  impact 1.0
  title 'Ensure AWS DMS Replication Subnet Group has the correct properties.'
  describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'test1') do
    its('replication_subnet_group_identifier') { should eq "test1"}
    its('replication_subnet_group_description') { should eq "test1"}
    its('vpc_id') { should eq "vpc-01234567890"}
    its('subnet_group_status') { should eq "Complete"}
    its('subnets.first.subnet_identifier') { should eq "subnet-01234567890"}
    its('subnets.first.subnet_availability_zone.name') { should eq "us-east-2b"}
    its('subnets.first.subnet_status') { should eq "Active"}
  end
end