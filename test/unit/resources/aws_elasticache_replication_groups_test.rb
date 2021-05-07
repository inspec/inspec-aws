require 'helper'
require 'aws_elasticache_replication_groups'
require "aws-sdk-core"
require_relative 'mock/aws_elasticache_cluster_mock'

class AwsElastiCacheReplicationGroupsConstructorTest < Minitest::Test

  def test_empty_params_ok
    assert AwsElastiCacheReplicationGroups.new(client_args: { stub_responses: true })
  end

  def test_reject_other_args
    assert_raises(ArgumentError) { AwsElastiCacheReplicationGroups.new('rubbish') }
  end

  def test_non_existing_resources_for_empty_response
    refute AwsElastiCacheReplicationGroups.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsElastiCacheReplicationGroupsTest < Minitest::Test

  def setup
    # Create a number of mock Replication Groups
    number_of_fs = 5
    mock_replication_group_list = AwsElastiCacheReplicationGroupMock.new.multiple(number_of_fs)

    # Create stub data.
    data = {}
    data[:data] = { :replication_groups => mock_replication_group_list }
    data[:client] = Aws::ElastiCache::Client
    data[:method] = :describe_replication_groups

    # This is for brevity.
    @m_c = mock_replication_group_list

    # Create a stub replication group with mock replication group data.
    @replication_group_list = AwsElastiCacheReplicationGroups.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_exists
    assert @replication_group_list.exist?
  end

  def test_id
    @replication_group_list.ids.zip(@m_c).each do |c_id, m_c|
      assert_equal(c_id, m_c[:replication_group_id])
    end
  end

  def test_node_type
    @replication_group_list.node_types.zip(@m_c).each do |c_n, m_c|
      assert_equal(c_n, m_c[:cache_node_type])
    end
  end

  def test_status
    @replication_group_list.status.zip(@m_c).each do |c_s, m_c|
      assert_equal(c_s, m_c[:status])
    end
  end

  def test_encrypted_at_rest
    @replication_group_list.encrypted_at_rest.zip(@m_c).each do |c_e, m_c|
      assert_equal(c_e, m_c[:at_rest_encryption_enabled])
    end
  end

  def test_encrypted_at_transit
    @replication_group_list.encrypted_at_transit.zip(@m_c).each do |c_t, m_c|
      assert_equal(c_t, m_c[:transit_encryption_enabled])
    end
  end
end
