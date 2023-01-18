aws_elasticache_replication_group_id = input(:aws_elasticache_replication_group_id, value: '', description: 'The AWS ElastiCache Replication Group ID.')
aws_elasticache_replication_group_node_type = input(:aws_elasticache_replication_group_node_type, value: '', description: 'The AWS ElastiCache replication group node type.')

title 'Test single AWS ElastiCache Replication Group'

control 'aws-elasticache-replication-group-1.0' do
  title 'Ensure AWS ElastiCache Replication Group has the correct properties.'

  describe aws_elasticache_replication_group(replication_group_id: aws_elasticache_replication_group_id) do
    it { should exist }
    it { should be_encrypted_at_rest }
    it { should_not be_encrypted_at_transit }
    its('cache_node_type') { should eq aws_elasticache_replication_group_node_type }
  end

  describe aws_elasticache_replication_group('not-there') do
    it { should_not exist }
  end
end
