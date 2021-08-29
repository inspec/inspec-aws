require 'helper'
require 'aws_rds_snapshot_attributes'
require 'aws-sdk-core'

class AwsRdsSnapshotAttributesConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsRdsSnapshotAttributes.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsRdsSnapshotAttributes.new('*rubbish*') }
  end

  def test_accepts_valid_db_snapshot_identifier
    AwsRdsSnapshotAttributes.new(db_snapshot_identifier: 'rds-012b75749d0b5ceb5', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsRdsSnapshotAttributes.new(rubbish: 9) }
  end

  def test_rejects_invalid_db_snapshot_identifier
    assert_raises(ArgumentError) { AwsRdsSnapshotAttributes.new(db_snapshot_identifier: 'rds_rubbish') }
  end

  def test_rds_non_existing
    refute AwsRdsSnapshotAttributes.new(db_snapshot_identifier: 'rds-012b75749d0b5ceb5', client_args: { stub_responses: true }).exists?
  end
end

class AwsRdsSnapshotAttributesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_snapshot_attributes
    mock_snapshot_atrribute = {}
    mock_snapshot_atrribute[:db_snapshot_identifier] = 'rds-012b75749d0b5ceb5'
    data[:data] = { :db_snapshot_attributes_result.to_h => [mock_snapshot_atrribute] }
    data[:client] = Aws::RDS::Client
    @snapshot = AwsRdsSnapshotAttributes.new(db_snapshot_identifier: 'rds-012b75749d0b5ceb5', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_snapshot_exists
    assert @snapshot.exists?
  end

  def test_snapshot_id
    assert_equal(@snapshot.db_snapshot_identifier,  'rds-012b75749d0b5ceb5')
  end
end
