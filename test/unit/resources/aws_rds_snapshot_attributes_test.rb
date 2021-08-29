require 'helper'
require 'aws_rds_snapshot_attributes'
require 'aws-sdk-core'

class AwsRdsSnapshotAttributesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsRdsSnapshotAttributes.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsRdsSnapshotAttributes.new('rubbish') }
  end

  def test_snapshots_non_existing_for_empty_response
    refute AwsRdsSnapshotAttributes.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsRdsSnapshotAttributesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_snapshot_attributes
    mock_snapshot_atrribute = {}
    mock_snapshot_atrribute[:db_snapshot_identifier] = 'rds-012b75749d0b5ceb5'
    data[:data] = { :db_snapshot_attributes_result => [mock_snapshot_atrribute] }
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
