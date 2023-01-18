require "aws_backend"

class AWSSESResourceDataSyncs < AwsResourceBase
  name "aws_ssm_resource_data_syncs"
  desc "Lists your resource data sync configurations. Includes information about the last time a sync attempted to start, the last sync status, and the last time a sync successfully completed."

  example "
    describe aws_ssm_resource_data_syncs do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:sync_names, field: :sync_name)
    .register_column(:sync_types, field: :sync_type)
    .register_column(:sync_sources, field: :sync_source)
    .register_column(:s3_destinations, field: :s3_destination)
    .register_column(:last_sync_times, field: :last_sync_time)
    .register_column(:last_successful_sync_times, field: :last_successful_sync_time)
    .register_column(:sync_last_modified_times, field: :sync_last_modified_time)
    .register_column(:last_statuses, field: :last_status)
    .register_column(:sync_created_times, field: :sync_created_time)
    .register_column(:last_sync_status_messages, field: :last_sync_status_message)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.ssm_client.list_resource_data_sync.map do |table|
        table.resource_data_sync_items.map { |table_name| {
          sync_name: table_name.sync_name,
          sync_type: table_name.sync_type,
          sync_source: table_name.sync_source,
          s3_destination: table_name.s3_destination,
          last_sync_time: table_name.last_sync_time,
          last_successful_sync_time: table_name.last_successful_sync_time,
          sync_last_modified_time: table_name.sync_last_modified_time,
          last_status: table_name.last_status,
          sync_created_time: table_name.sync_created_time,
          last_sync_status_message: table_name.last_sync_status_message,
        }
        }
      end.flatten
    end
  end
end
