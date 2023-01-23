require 'helper'
require 'aws_rds_snapshot'
require 'aws-sdk-core'

class AwsRdsSnapshotConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsRdsSnapshot.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsRdsSnapshot.new('*rubbish*') }
  end

  def test_accepts_valid_db_snapshot_identifier
    AwsRdsSnapshot.new(db_snapshot_identifier: 'rds-1234abcd', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsRdsSnapshot.new(rubbish: 9) }
  end

  def test_rejects_invalid_db_snapshot_identifier
    assert_raises(ArgumentError) { AwsRdsSnapshot.new(db_snapshot_identifier: 'rds_rubbish') }
  end

  def test_db_snapshots_non_existing
    refute AwsRdsSnapshot.new(db_snapshot_identifier: 'rds-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsRdsSnapshotTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_snapshots
    mock_rds_snapshot = {}
    mock_rds_snapshot[:db_snapshot_identifier] = 'rds-12345678'
    mock_rds_snapshot[:allocated_storage] = 100
    mock_rds_snapshot[:engine] = 'mysql'
    mock_rds_snapshot[:engine_version] = '1.2.3'
    mock_rds_snapshot[:master_username] = 'starlord'
    data[:data] = { :db_snapshots => [mock_rds_snapshot] }
    data[:client] = Aws::RDS::Client
    @rds = AwsRdsSnapshot.new(db_snapshot_identifier: 'rds-12345678', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@rds.resource_id)
    assert_equal(@rds.resource_id, @rds.db_snapshot_identifier)
  end

  def test_rds_exists
    assert @rds.exists?
  end

  def test_db_id
    assert_equal(@rds.db_snapshot_identifier,  'rds-12345678')
  end

  def test_db_storage
    assert_equal(@rds.allocated_storage, 100)
  end

  def test_rds_engine
    assert_equal(@rds.engine, 'mysql')
  end

  def test_rds_engine_version
    assert_equal(@rds.engine_version, '1.2.3')
  end

  def test_rds_user
    assert_equal(@rds.master_username, 'starlord')
  end
end
