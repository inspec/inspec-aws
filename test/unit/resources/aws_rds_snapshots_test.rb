require 'helper'
require 'aws_rds_snapshots'
require 'aws-sdk-core'

class AwsRdsSnapshotsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsRdsSnapshots.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsRdsSnapshots.new('rubbish') }
  end
end

class AwsRdsSnapshotsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_snapshots
    mock_snapshot = {}
    mock_snapshot[:db_snapshot_identifier] = 'rds-012b75749d0b5ceb5'
    data[:data] = { :db_snapshots => [mock_snapshot] }
    data[:client] = Aws::RDS::Client
    @snapshots = AwsRdsSnapshots.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_snapshots_exists
    assert @snapshots.exist?
  end

  def test_snapshots_ids
    assert_equal(@snapshots.db_snapshot_identifiers, ['rds-012b75749d0b5ceb5'])
  end

  def test_snapshots_filtering_not_there
    refute @snapshots.where(:db_snapshot_identifier => 'bad').exist?
  end

  def test_snapshots_filtering_there
    assert @snapshots.where(:db_snapshot_identifier => 'rds-012b75749d0b5ceb5').exist?
  end
end
