require 'helper'
require 'aws_dms_replication_instances'
require 'aws-sdk-core'

class AWSDMSReplicationInstancesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSDMSReplicationInstances.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSDMSReplicationInstances.new('rubbish') }
  end

  def test_orderable_replication_instances_non_existing_for_empty_response
    refute AWSDMSReplicationInstances.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSDMSReplicationInstancesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_orderable_replication_instances
    mock_parameter = {}
    mock_parameter[:engine_version] = 'test1'
    mock_parameter[:replication_instance_class] = 'test1'
    mock_parameter[:storage_type] = 'test1'
    mock_parameter[:min_allocated_storage] = 0
    mock_parameter[:max_allocated_storage] = 1
    mock_parameter[:default_allocated_storage] = 1
    mock_parameter[:included_allocated_storage] = 1
    mock_parameter[:availability_zones] = ['test1']
    mock_parameter[:release_status] = 'test1'
    data[:data] = { :orderable_replication_instances => [mock_parameter] }
    data[:client] = Aws::DatabaseMigrationService::Client
    @orderable_replication_instances = AWSDMSReplicationInstances.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_orderable_replication_instances_exists
    assert @orderable_replication_instances.exist?
  end

  def test_engine_versions
    assert_equal(@orderable_replication_instances.engine_versions, ['test1'])
  end

  def test_replication_instance_classes
    assert_equal(@orderable_replication_instances.replication_instance_classes, ['test1'])
  end

  def test_storage_types
    assert_equal(@orderable_replication_instances.storage_types, ['test1'])
  end

  def test_min_allocated_storages
    assert_equal(@orderable_replication_instances.min_allocated_storages, [0])
  end

  def test_max_allocated_storages
    assert_equal(@orderable_replication_instances.max_allocated_storages, [1])
  end

  def test_default_allocated_storages
    assert_equal(@orderable_replication_instances.default_allocated_storages, [1])
  end

  def test_included_allocated_storages
    assert_equal(@orderable_replication_instances.included_allocated_storages, [1])
  end

  def test_availability_zones
    assert_equal(@orderable_replication_instances.availability_zones, [['test1']])
  end

  def test_release_statuses
    assert_equal(@orderable_replication_instances.release_statuses, ['test1'])
  end
end

