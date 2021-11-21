require 'helper'
require 'aws_rds_db_cluster_snapshot'
require 'aws-sdk-core'

class AWSRDSDBClusterSnapShotConstructorTest < Minitest::Test

  def test_non_empty_params_ok
    AWSRDSDBClusterSnapShot.new(db_cluster_snapshot_id: 'default:aurora-5-6', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSRDSDBClusterSnapShot.new(option_gpp:'rubbish') }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRDSDBClusterSnapShot.new(rubbish: 9) }
  end
end

class AWSRDSDBClusterSnapShotHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_cluster_snapshots
    mock_data = {}
    mock_data[:db_cluster_snapshot_identifier] = 'default:aurora-5-6'
    mock_data[:db_cluster_identifier] = 'test_snapshot'
    mock_data[:snapshot_create_time] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:engine] = 'aurora'
    mock_data[:db_cluster_snapshot_arn] = 'arn:aws:rds:us-east-2:99999999:og:default:aurora-5-6'
    mock_data[:engine_version] = '1'
    data[:data] = { :db_cluster_snapshots => [mock_data] }
    data[:client] = Aws::RDS::Client
    @resp = AWSRDSDBClusterSnapShot.new(db_cluster_snapshot_id: 'default:aurora-5-6', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_db_cluster_snapshot_ids
    assert_equal(@resp.db_cluster_snapshot_identifier, 'default:aurora-5-6')
  end

  def test_db_cluster_identifier_exists
    assert @resp.exists?
  end

  def test_db_cluster_snapshot_id_available
    assert @resp.available?
  end

  def test_engine
    assert_equal(@resp.engine, 'aurora')
  end

  def test_db_cluster_snapshot_arn
    assert_equal(@resp.db_cluster_snapshot_arn, 'arn:aws:rds:us-east-2:99999999:og:default:aurora-5-6')
  end
end


