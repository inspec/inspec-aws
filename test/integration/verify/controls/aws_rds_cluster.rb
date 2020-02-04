title 'Test single AWS Aurora Cluster'

aws_rds_cluster_identifier = attribute(:aws_rds_cluster_identifier, default: '', description: 'The AWS RDS Cluster identifier.')
aws_rds_cluster_database_name = attribute(:aws_rds_cluster_database_name, default: '', description: 'The AWS RDS Cluster name.')
aws_rds_cluster_engine = attribute(:aws_rds_cluster_engine, default: '', description: 'The AWS RDS Cluster engine.')
aws_rds_cluster_engine_version = attribute(:aws_rds_cluster_engine_version, default: '', description: 'The AWS RDS Cluster engine version.')
aws_rds_cluster_master_user = attribute(:aws_rds_cluster_master_user, default: '', description: 'The AWS RDS Cluster username.')


control 'aws-rds-cluster-1.0' do

  impact 1.0
  title 'Ensure AWS RDS Cluster has the correct properties.'

  describe aws_rds_cluster(db_cluster_identifier: aws_rds_cluster_identifier) do
    it { should exist }
    it { should have_encrypted_storage }
    its('storage_encrypted') { should eq true }
    its('database_name') { should eq aws_rds_cluster_database_name }
    its('engine') { should eq aws_rds_cluster_engine }
    its('engine_version') { should eq aws_rds_cluster_engine_version }
    its('master_username') { should eq aws_rds_cluster_master_user }
    its('allocated_storage') { should eq 1 }
    its('tags') { should include('Name' => aws_rds_cluster_database_name) }
    its('db_cluster_members') { should include 'instance1' }
    its('db_cluster_members') { should include 'instance2' }
    its('status') { should eq 'available' }
    its('multi_az') { should eq true }
  end

  describe aws_rds_cluster(aws_rds_cluster_identifier) do
    it { should exist }
  end

  describe aws_rds_cluster('not-there') do
    it { should_not exist }
  end
end