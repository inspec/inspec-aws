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
end

class AwsRdsSnapshotAttributesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_snapshot_attributes
    mock_snapshot_attribute = {}
    mock_snapshot_attribute[:db_snapshot_identifier] = 'rds-012b75749d0b5ceb5'
    mock_snapshot_attribute[:db_snapshot_attributes] = [{
      attribute_name: "restore",
      attribute_values: ["all"]
    }]
    data[:data] = { :db_snapshot_attributes_result => mock_snapshot_attribute }
    data[:client] = Aws::RDS::Client
    @snapshot = AwsRdsSnapshotAttributes.new(db_snapshot_identifier: 'rds-012b75749d0b5ceb5', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_snapshot_exists
    assert @snapshot.exists?
  end

  def test_snapshot_id
    assert_equal(@snapshot.db_snapshot_identifier,  ['rds-012b75749d0b5ceb5'])
  end

  def test_attr_name
    assert_equal(@snapshot.attribute_name, ['restore'])
  end

  def test_attr_value
    assert_equal(@snapshot.attribute_values, [['all']])
  end
end
