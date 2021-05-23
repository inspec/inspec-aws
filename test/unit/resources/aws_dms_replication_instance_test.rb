require 'helper'
require 'aws_dms_replication_instance'
require 'aws-sdk-core'

class AWSDMSReplicationInstanceConstructorTest < Minitest::Test

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSDMSReplicationInstance.new(unexpected: 9) }
  end
end

# class AWSDMSReplicationInstanceSuccessPathTest < Minitest::Test

#   def setup
#     data = {}
#     data[:method] = :describe_orderable_replication_instances
#     mock_parameter = {}
#     mock_parameter[:engine_version] = 'test1'
#     mock_parameter[:replication_instance_class] = 'test1'
#     mock_parameter[:storage_type] = 'test1'
#     mock_parameter[:min_allocated_storage] = 1
#     mock_parameter[:max_allocated_storage] = 1
#     mock_parameter[:default_allocated_storage] = 1
#     mock_parameter[:included_allocated_storage] = 1
#     mock_parameter[:availability_zones] = ['test1']
#     mock_parameter[:release_status] = 'test1'
#     data[:data] = [mock_parameter]
#     data[:client] = Aws::DatabaseMigrationService::Client
#     @orderable_replication_instances = AWSDMSReplicationInstance.new(client_args: { stub_responses: true }, stub_data: [data])
#   end

#   def test_orderable_replication_instances_exists
#     assert @orderable_replication_instances.exists?
#   end

#   def test_engine_version
#     assert_equal(@orderable_replication_instances.engine_version, 'test1')
#   end

#   def test_replication_instance_class
#     assert_equal(@orderable_replication_instances.replication_instance_class, 'test1')
#   end

#   def test_storage_type
#     assert_equal(@orderable_replication_instances.storage_type, 'test1')
#   end

#   def test_min_allocated_storage
#     assert_equal(@orderable_replication_instances.allow_classic_flow, 1)
#   end

#   def test_max_allocated_storage
#     assert_equal(@orderable_replication_instances.max_allocated_storage, 1)
#   end

#   def test_default_allocated_storage
#     assert_equal(@orderable_replication_instances.default_allocated_storage, 1)
#   end

#   def test_included_allocated_storage
#     assert_equal(@orderable_replication_instances.included_allocated_storage, 1)
#   end

#   def test_availability_zones
#     assert_equal(@orderable_replication_instances.availability_zones, ['test1'])
#   end

#   def test_release_status
#     assert_equal(@orderable_replication_instances.release_status, 'test1')
#   end
# end