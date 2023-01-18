title 'Test a AWS ElastiCache Cluster Node'

aws_elasticache_cluster_id = input(:aws_elasticache_cluster_id, value: '', description: 'The AWS ElastiCache Cluster ID.')
aws_elasticache_cluster_port = input(:aws_elasticache_cluster_port, value: '', description: 'The AWS ElastiCache Cluster port number.')

control 'aws-elasticache-cluster-node-1.0' do
  title 'Ensure AWS ElastiCache Cluster node has the correct properties.'

  aws_elasticache_cluster(cache_cluster_id: aws_elasticache_cluster_id).node_ids.each do |node_id|
    describe aws_elasticache_cluster_node(cache_cluster_id: aws_elasticache_cluster_id, node_id: node_id) do
      it { should exist }
      its('port') { should cmp aws_elasticache_cluster_port }
    end
  end
end
