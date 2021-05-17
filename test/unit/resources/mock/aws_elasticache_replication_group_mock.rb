require_relative 'aws_base_resource_mock'

class AwsElastiCacheReplicationGroupMock < AwsBaseResourceMock
  ENCRYPTED = [true, false].freeze

  def multiple(n)
    # Create multiple Elasticache Replication Groups
    mocks = []
    n.times do
      mocks << {
          replication_group_id: @aws.any_string,
          cache_node_type: "cache.t2.micro",
          status: "available",
          auth_token_enabled: false,
          transit_encryption_enabled: true,
          at_rest_encryption_enabled: true,
      }
    end
    mocks.freeze
  end
end
