require "aws_backend"

class AWSDMSReplicationInstances < AwsResourceBase
  name "aws_dms_replication_instances"
  desc "Returns information about the replication instance types that can be created in the specified region."
  example "
    describe aws_dms_replication_instances do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:engine_versions,                     field: :engine_version)
    .register_column(:replication_instance_classes,        field: :replication_instance_class)
    .register_column(:storage_types,                       field: :storage_type)
    .register_column(:min_allocated_storages,              field: :min_allocated_storage)
    .register_column(:max_allocated_storages,              field: :max_allocated_storage)
    .register_column(:default_allocated_storages,          field: :default_allocated_storage)
    .register_column(:included_allocated_storages,         field: :included_allocated_storage)
    .register_column(:availability_zones,                  field: :availability_zones)
    .register_column(:release_statuses,                    field: :release_status)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.dmsmigrationservice_client.describe_orderable_replication_instances
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.orderable_replication_instances.map(&:to_h)
  end
end
