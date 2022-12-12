global_cluster_identifier = input(:global_cluster_identifier, value: '', description: '')

control 'aws_rds_global_cluster-1.0' do
  title 'Test the properties of a Global cluster.'
  
  describe aws_rds_global_cluster(global_cluster_identifier: global_cluster_identifier) do
    it { should exist }
    its('global_cluster_identifier') { should eq global_cluster_identifier }
    its('global_cluster_resource_id') { should_not eq 'cluster-7355440cd5620115' }
    its('global_cluster_arn') { should_not eq 'arn:aws:rds::546464644:global-cluster:global-test-1' }
    its('status') { should_not eq 'unavailable' }
  end
end
