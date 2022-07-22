global_cluster_identifier = input(:global_cluster_identifier, value: '', description: '')

control 'aws_rds_global_clusters-1.0' do
  impact 1.0
  title 'Test the properties of all the Global cluster.'
  
  describe aws_rds_global_clusters do
    it { should exist }
    its('global_cluster_identifiers') { should_not include global_cluster_identifier }
    its('global_cluster_resource_ids') { should_not include 'cluster-7355440cd5620115' }
    its('global_cluster_arns') { should_not include 'arn:aws:rds::3646654567:global-cluster:global-test-1' }
    its('statuses') { should_not include 'unavailable' }
  end
end
