require 'helper'
require 'aws_elasticache_clusters'
require "aws-sdk-core"
require_relative 'mock/aws_elasticache_cluster_mock'

class AwsElastiCacheClustersConstructorTest < Minitest::Test

  def test_empty_params_ok
    assert AwsElastiCacheClusters.new(client_args: { stub_responses: true })
  end

  def test_reject_other_args
    assert_raises(ArgumentError) { AwsElastiCacheClusters.new('rubbish') }
  end

  def test_non_existing_resources_for_empty_response
    refute AwsElastiCacheClusters.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsElastiCacheClustersTest < Minitest::Test

  def setup
    # Create a number of mock cluster
    number_of_fs = 5
    mock_cluster_list = AwsElastiCacheClusterMock.new.multiple(number_of_fs)

    # Create stub data.
    data = {}
    data[:data] = { :cache_clusters => mock_cluster_list }
    data[:client] = Aws::ElastiCache::Client
    data[:method] = :describe_cache_clusters

    # This is for brevity.
    @m_c = mock_cluster_list

    # Create a stub clusters with mock cluster data.
    @cache_cluster_list = AwsElastiCacheClusters.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_exists
    assert @cache_cluster_list.exist?
  end

  def test_id
    @cache_cluster_list.ids.zip(@m_c).each do |c_id, m_c|
      assert_equal(c_id, m_c[:cache_cluster_id])
    end
  end

  def test_node_type
    @cache_cluster_list.node_types.zip(@m_c).each do |c_n, m_c|
      assert_equal(c_n, m_c[:cache_node_type])
    end
  end

  def test_status
    @cache_cluster_list.status.zip(@m_c).each do |c_s, m_c|
      assert_equal(c_s, m_c[:cache_cluster_status])
    end
  end

  def test_encrypted_at_rest
    @cache_cluster_list.encrypted_at_rest.zip(@m_c).each do |c_e, m_c|
      assert_equal(c_e, m_c[:at_rest_encryption_enabled])
    end
  end

  def test_encrypted_at_transit
    @cache_cluster_list.encrypted_at_transit.zip(@m_c).each do |c_t, m_c|
      assert_equal(c_t, m_c[:transit_encryption_enabled])
    end
  end

  def test_engine
    @cache_cluster_list.engines.zip(@m_c).each do |c_e, m_c|
      assert_equal(c_e, m_c[:engine])
    end
  end
end
