require 'helper'
require 'aws_elasticache_replication_group'
require "aws-sdk-core"
require_relative 'mock/aws_elasticache_replication_group_mock'

class AwsElastiCacheReplicationGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsElastiCacheReplicationGroup.new() }
  end

  def test_integer_params_not_ok
    assert_raises(ArgumentError) { AwsElastiCacheReplicationGroup.new(1234) }
  end

  def test_rejects_invalid_replication_group_id
    assert_raises(ArgumentError) { AwsElastiCacheReplicationGroup.new('a'*60) }
  end

  def test_rejects_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsElastiCacheReplicationGroup.new(rubbish_id: 'fs-12345678') }
  end

  def test_accepts_replication_group_id_as_identifier
    assert AwsElastiCacheReplicationGroup.new(replication_group_id: 'id-12345678', client_args: { stub_responses: true })
  end

  def test_replication_group_non_existing_creation_token
    refute AwsElastiCacheReplicationGroup.new(replication_group_id: 'my-id', client_args: { stub_responses: true }).exists?
  end

end

class AwsElastiCacheReplicationGroupTest < Minitest::Test

  def setup
    # Create a mock replication group
    number_of_fs = 1
    mock_replication_group_list = AwsElastiCacheReplicationGroupMock.new.multiple(number_of_fs)

    # Create stub data.
    data = {}
    data[:data] = { :replication_groups => mock_replication_group_list }
    data[:client] = Aws::ElastiCache::Client
    data[:method] = :describe_replication_groups

    # This is for brevity.
    @m_c = mock_replication_group_list.first

    # Create a stub Replication Groups with mock cluster data.
    @replication_group = AwsElastiCacheReplicationGroup.new(
        replication_group_id: @m_c[:replication_group_id],
        client_args: { stub_responses: true },
        stub_data: [data]
    )
  end

  def test_exists
    assert @replication_group.exists?
  end

  def test_id
    assert_equal(@replication_group.id, @m_c[:replication_group_id])
  end

  def test_status
    assert_equal(@replication_group.status, @m_c[:status])
  end

  def test_encrypted_at_rest
    assert_equal(@replication_group.encrypted_at_rest?, @m_c[:at_rest_encryption_enabled])
  end

  def test_encrypted_at_transit
    assert_equal(@replication_group.encrypted_at_transit?, @m_c[:transit_encryption_enabled])
  end
end
