require 'helper'
require 'aws_redshift_clusters'
require 'aws-sdk-core'

class AwsRedshiftClustersConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsRedshiftClusters.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsRedshiftClusters.new('rubbish') }
  end

  def test_redshift_clusters_non_existing_for_empty_response
    refute AwsRedshiftClusters.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsRedshiftClustersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_clusters
    mock_rds = {}
    mock_rds[:cluster_identifier] = 'cluster-12345678'
    mock_rds[:encrypted] = true
    mock_rds[:db_name] = 'clusterdb'
    mock_rds[:master_username] = "uname1"

    another_rds = {}
    another_rds[:cluster_identifier] = 'cluster-87654321'
    another_rds[:encrypted] = true
    another_rds[:db_name] = 'clusterdb2'
    another_rds[:master_username] = "uname2"
    data[:data] = { clusters: [mock_rds, another_rds] }
    data[:client] = Aws::Redshift::Client
    @rds_clusters = AwsRedshiftClusters.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_clusters_exists
    assert @rds_clusters.exist?
  end

  def test_clusters_filtering_not_there
    refute @rds_clusters.where(cluster_identifier: 'bad').exist?
  end

  def test_clusters_filtering_there
    assert @rds_clusters.where(cluster_identifier: 'cluster-12345678').exist?
  end
end


