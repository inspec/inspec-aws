require 'helper'
require 'aws_elasti_cache_cluster_node'
require "aws-sdk-core"
require_relative 'mock/aws_elasti_cache_cluster_mock'

# class AwsElastiCacheClusterNodeConstructorTest < Minitest::Test
#
#   def test_empty_params_not_ok
#     assert_raises(ArgumentError) { AwsElastiCacheClusterNode.new() }
#   end
#
#   def test_integer_params_not_ok
#     assert_raises(ArgumentError) { AwsElastiCacheClusterNode.new(1234) }
#   end
#
#   def test_rejects_invalid_cluster_id
#     assert_raises(ArgumentError) { AwsElastiCacheClusterNode.new('a'*60) }
#   end
#
#   def test_rejects_unrecognized_identifiers
#     assert_raises(ArgumentError) { AwsElastiCacheClusterNode.new(rubbish_id: 'fs-12345678') }
#   end
#
#   def test_accepts_cache_cluster_id_as_identifier
#     assert AwsElastiCacheClusterNode.new(cache_cluster_id: 'id-12345678', client_args: { stub_responses: true })
#   end
#
#   def test_cache_cluster_non_existing_creation_token
#     refute AwsElastiCacheClusterNode.new(cache_cluster_id: 'my-id', client_args: { stub_responses: true }).exists?
#   end
#
# end

class AwsElastiCacheClusterNodeTest < Minitest::Test

  def setup
    # Create a mock cluster.
    number_of_fs = 1
    mock_cluster_list = AwsElastiCacheClusterMock.new.multiple(number_of_fs)

    # Create the stub data.
    data = {}
    data[:data] = { :cache_clusters => mock_cluster_list }
    data[:client] = Aws::ElastiCache::Client
    data[:method] = :describe_cache_clusters

    # There is only one mock cluster, take the first from the list.
    mock_cluster = mock_cluster_list.first
    # Choose the first node from the mock cluster as a mock node.
    @mock_node = mock_cluster[:cache_nodes].first

    # Create a stub cluster with mock cluster data.
    @cache_cluster_node = AwsElastiCacheClusterNode.new(
        cache_cluster_id: mock_cluster[:cache_cluster_id],
        node_id: @mock_node[:cache_node_id],
        client_args: { stub_responses: true },
        stub_data: [data]
    )
  end

  def test_exists
    assert @cache_cluster_node.exists?
  end

  def test_id
    assert_equal(@cache_cluster_node.id, @mock_node[:cache_node_id])
  end

  def test_port
    assert_equal(@cache_cluster_node.port, @mock_node[:endpoint][:port])
  end

  def test_address
    assert_equal(@cache_cluster_node.address, @mock_node[:endpoint][:address])
  end

  def test_status
    assert_equal(@cache_cluster_node.status, @mock_node[:cache_node_status])
  end

  def test_customer_availability_zone
    assert_equal(@cache_cluster_node.customer_availability_zone, @mock_node[:customer_availability_zone])
  end
end
