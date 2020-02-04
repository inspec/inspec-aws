require 'helper'
require 'aws_rds_clusters'
require 'aws-sdk-core'

class AwsRdsClustersConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsRdsClusters.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsRdsClusters.new('rubbish') }
  end

  def test_clusters_non_existing_for_empty_response
    refute AwsRdsClusters.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsRdsClustersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_clusters
    mock_rds = {}
    mock_rds[:db_cluster_identifier] = 'cluster-12345678'
    mock_rds[:allocated_storage] = 100
    mock_rds[:database_name] = 'clusterdb'
    mock_rds[:db_cluster_members] = [{db_instance_identifier: "cluster-12345678-member-1"}]

    another_rds = {}
    another_rds[:db_cluster_identifier] = 'cluster-87654321'
    another_rds[:allocated_storage] = 100
    another_rds[:database_name] = 'clusterdb2'
    another_rds[:db_cluster_members] = [{db_instance_identifier: "cluster-12345678-member-2"}]
    data[:data] = { db_clusters: [mock_rds, another_rds] }
    data[:client] = Aws::RDS::Client
    @rds_clusters = AwsRdsClusters.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_clusters_exists
    assert @rds_clusters.exist?
  end

  def test_cluster_ids
    assert_equal(@rds_clusters.cluster_identifier, ['cluster-12345678', 'cluster-87654321'])
  end

  def test_clusters_filtering_not_there
    refute @rds_clusters.where(cluster_identifier: 'bad').exist?
  end

  def test_clusters_filtering_there
    assert @rds_clusters.where(cluster_identifier: 'cluster-12345678').exist?
  end
end

