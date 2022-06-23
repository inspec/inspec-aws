aws_elasticache_replication_group_id = input(:aws_elasticache_replication_group_id, value: '', description: 'The AWS ElastiCache Replication Group ID.')

title 'Test multiple AWS ElastiCache Replication Group'

control 'aws-elasticache-replication-groups-1.0' do
  impact 1.0
  title 'Ensure AWS ElastiCache Replication Groups has the correct properties.'

  describe aws_elasticache_replication_groups do
    it { should exist }
    its('count') { should be >= 1 }
    its('ids') { should include aws_elasticache_replication_group_id }
  end
end