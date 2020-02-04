require 'helper'
require 'aws_rds_cluster'
require 'aws-sdk-core'

class AwsRdsClusterConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsRdsCluster.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsRdsCluster.new('*rubbish*') }
  end

  def test_accepts_valid_db_cluster_identifier
    AwsRdsCluster.new(db_cluster_identifier: 'rds-1234abcd', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsRdsCluster.new(rubbish: 9) }
  end

  def test_rejects_invalid_db_cluster_identifier
    assert_raises(ArgumentError) { AwsRdsCluster.new(db_cluster_identifier: 'rds_rubbish') }
  end

  def test_rds_non_existing
    refute AwsRdsCluster.new(db_cluster_identifier: 'rds-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsRdsClusterTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_db_clusters
    mock_cluster = {}
    mock_cluster[:db_cluster_identifier] = 'cluster-12345678'
    mock_cluster[:allocated_storage] = 100
    mock_cluster[:availability_zones] = ['us-west-2a', 'us-west-2b', 'us-west-2c']
    mock_cluster[:multi_az] = true
    mock_cluster[:engine] = 'aurora-mysql'
    mock_cluster[:engine_version] = '1.2.3'
    mock_cluster[:master_username] = 'starlord'
    mock_cluster[:database_name] = 'clusterdb'
    mock_cluster[:db_cluster_members] = [{db_instance_identifier: "cluster-12345678-member-1",
                                          is_cluster_writer: false,
                                          db_cluster_parameter_group_status: "pending-reboot",
                                          promotion_tier: 1}]
    mock_cluster[:status] = 'available'
    data[:data] = { db_clusters: [mock_cluster] }
    data[:client] = Aws::RDS::Client
    @cluster = AwsRdsCluster.new(db_cluster_identifier: 'cluster-12345678', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_cluster_exists
    assert @cluster.exists?
  end

  def test_cluster_identifier
    assert_equal(@cluster.db_cluster_identifier, 'cluster-12345678')
  end

  def test_cluster_storage
    assert_equal(@cluster.allocated_storage, 100)
  end

  def test_cluster_class
    assert_equal(@cluster.availability_zones, ['us-west-2a', 'us-west-2b', 'us-west-2c'])
  end

  def test_cluster_engine
    assert_equal(@cluster.engine, 'aurora-mysql')
  end

  def test_cluster_engine_version
    assert_equal(@cluster.engine_version, '1.2.3')
  end

  def test_cluster_master_username
    assert_equal(@cluster.master_username, 'starlord')
  end

  def test_cluster_database_name
    assert_equal(@cluster.database_name, 'clusterdb')
  end

  def test_cluster_members
    assert_equal(@cluster.db_cluster_members, ['cluster-12345678-member-1'])
  end

  def test_cluster_status
    assert_equal(@cluster.status, 'available')
  end
end
