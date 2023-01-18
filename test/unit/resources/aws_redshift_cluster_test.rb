require 'helper'
require 'aws_redshift_cluster'
require 'aws-sdk-core'

class AwsRedshiftClusterConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsRedshiftCluster.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsRedshiftCluster.new('*rubbish*') }
  end

  def test_accepts_valid_cluster_identifier
    AwsRedshiftCluster.new(cluster_identifier: 'rds-1234abcd', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsRedshiftCluster.new(rubbish: 9) }
  end

  def test_rejects_invalid_cluster_identifier
    assert_raises(ArgumentError) { AwsRedshiftCluster.new(cluster_identifier: 'rds_rubbish') }
  end

  def test_redshift_cluster_non_existing
    refute AwsRedshiftCluster.new(cluster_identifier: 'rds-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsRedshiftClusterTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_clusters
    mock_cluster = {}
    mock_cluster[:cluster_identifier] = 'cluster-12345678'
    mock_cluster[:cluster_availability_status] = "available"
    mock_cluster[:master_username] = 'aurora-mysql'
    mock_cluster[:db_name] = '1.2.3'
    mock_cluster[:kms_key_id] = 'starlord'
    mock_cluster[:number_of_nodes] = 10
    # mock_cluster[:status] = 'available'
    data[:data] = { clusters: [mock_cluster] }
    data[:client] = Aws::Redshift::Client
    @cluster = AwsRedshiftCluster.new(cluster_identifier: 'cluster-12345678', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@cluster.resource_id)
    assert_equal(@cluster.resource_id, @cluster.cluster_identifier)
  end

  def test_cluster_exists
    assert @cluster.exists?
  end

  def test_cluster_identifier
    assert_equal(@cluster.cluster_identifier, 'cluster-12345678')
  end

  def test_cluster_master_username
    assert_equal(@cluster.master_username, 'aurora-mysql')
  end

  def test_cluster_db_name
    assert_equal(@cluster.db_name, '1.2.3')
  end

  def test_cluster_kms_key_id
    assert_equal(@cluster.kms_key_id, 'starlord')
  end

  def number_of_nodes
    assert_equal(@cluster.number_of_nodes, 10)
  end
end
