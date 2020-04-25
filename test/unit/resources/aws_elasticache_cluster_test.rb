require 'helper'
require 'aws_elasticache_cluster'
require "aws-sdk-core"
require_relative 'mock/aws_elasticache_cluster_mock'

class AwsElastiCacheClusterConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsElastiCacheCluster.new() }
  end

  def test_integer_params_not_ok
    assert_raises(ArgumentError) { AwsElastiCacheCluster.new(1234) }
  end

  def test_rejects_invalid_cluster_id
    assert_raises(ArgumentError) { AwsElastiCacheCluster.new('a'*60) }
  end

  def test_rejects_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsElastiCacheCluster.new(rubbish_id: 'fs-12345678') }
  end

  def test_accepts_cache_cluster_id_as_identifier
    assert AwsElastiCacheCluster.new(cache_cluster_id: 'id-12345678', client_args: { stub_responses: true })
  end

  def test_cache_cluster_non_existing_creation_token
    refute AwsElastiCacheCluster.new(cache_cluster_id: 'my-id', client_args: { stub_responses: true }).exists?
  end

end

class AwsElastiCacheClusterTest < Minitest::Test

  def setup
    # Create a mock cluster
    number_of_fs = 1
    mock_cluster_list = AwsElastiCacheClusterMock.new.multiple(number_of_fs)

    # Create stub data.
    data = {}
    data[:data] = { :cache_clusters => mock_cluster_list }
    data[:client] = Aws::ElastiCache::Client
    data[:method] = :describe_cache_clusters

    # This is for brevity.
    @m_c = mock_cluster_list.first

    # Create a stub clusters with mock cluster data.
    @cache_cluster = AwsElastiCacheCluster.new(
        cache_cluster_id: @m_c[:cache_cluster_id],
        client_args: { stub_responses: true },
        stub_data: [data]
    )
  end

  def test_exists
    assert @cache_cluster.exists?
  end

  def test_id
    assert_equal(@cache_cluster.id, @m_c[:cache_cluster_id])
  end

  def test_node_ids
    assert_equal(@cache_cluster.node_ids, @m_c[:cache_nodes].map { |node| node[:cache_node_id] })
  end

  def test_port
    assert_equal(@cache_cluster.ports[@m_c[:cache_nodes][0][:cache_node_id]], @m_c[:configuration_endpoint][:port])
  end

  def test_status
    assert_equal(@cache_cluster.status, @m_c[:cache_cluster_status])
  end

  def test_encrypted_at_rest
    assert_equal(@cache_cluster.encrypted_at_rest?, @m_c[:at_rest_encryption_enabled])
  end

  def test_encrypted_at_transit
    assert_equal(@cache_cluster.encrypted_at_transit?, @m_c[:transit_encryption_enabled])
  end

  def test_engine
    assert_equal(@cache_cluster.engine, @m_c[:engine])
  end
end
