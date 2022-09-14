aws_elasticache_cluster_id = input(:aws_elasticache_cluster_id, value: '', description: 'The AWS ElastiCache Cluster ID.')
aws_elasticache_cluster_engine = input(:aws_elasticache_cluster_engine, value: '', description: 'The AWS ElastiCache Custer engine.')

title 'Test multiple AWS ElastiCache Clusters'

control 'aws-elasticache-clusters-1.0' do
  impact 1.0
  title 'Ensure AWS ElastiCache Clusters have the correct properties.'

  describe aws_elasticache_clusters do
    it { should exist }
    its('count') { should be >= 1 }
    its('engines') { should include aws_elasticache_cluster_engine }
    its('ids') { should include aws_elasticache_cluster_id }
  end
end
