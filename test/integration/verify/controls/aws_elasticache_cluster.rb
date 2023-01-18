aws_elasticache_cluster_id = input(:aws_elasticache_cluster_id, value: '', description: 'The AWS ElastiCache Cluster ID.')
aws_elasticache_cluster_node_type = input(:aws_elasticache_cluster_node_type, value: '', description: 'The AWS ElastiCache Cluster node type.')
aws_elasticache_cluster_engine = input(:aws_elasticache_cluster_engine, value: '', description: 'The AWS ElastiCache Custer engine.')
aws_elasticache_cluster_engine_version = input(:aws_elasticache_cluster_engine_version, value: '', description: 'The AWS ElastiCache Cluster engine version.')
aws_elasticache_cluster_num_cache_nodes = input(:aws_elasticache_cluster_num_cache_nodes, value: '', description: 'The AWS ElastiCache Cluster number of cache nodes.')
aws_elasticache_cluster_parameter_group_name = input(:aws_elasticache_cluster_parameter_group_name, value: '', description: 'The AWS ElastiCache Cluster parameter group name.')

title 'Test single AWS ElastiCache Cluster'

control 'aws-elasticache-cluster-1.0' do
  title 'Ensure AWS ElastiCache Cluster has the correct properties.'

  describe aws_elasticache_cluster(cache_cluster_id: aws_elasticache_cluster_id) do
    it { should exist }
    it { should_not be_encrypted_at_rest }
    it { should_not be_encrypted_at_transit }
    its('engine') { should eq aws_elasticache_cluster_engine }
    its('engine_version') { should eq aws_elasticache_cluster_engine_version }
    its('num_cache_nodes') { should eq aws_elasticache_cluster_num_cache_nodes }
    its('cache_node_type') { should eq aws_elasticache_cluster_node_type }
    its('cache_parameter_group.cache_parameter_group_name') { should eq aws_elasticache_cluster_parameter_group_name }
  end

  describe aws_elasticache_cluster('not-there') do
    it { should_not exist }
  end
end
