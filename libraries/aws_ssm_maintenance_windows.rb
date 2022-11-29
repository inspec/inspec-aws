require 'aws_backend'

class AWSSESMaintenanceWindows < AwsResourceBase
  name 'aws_ssm_maintenance_windows'
  desc 'Retrieves the maintenance windows in an Amazon Web Services account.'

  example "
    describe aws_ssm_maintenance_windows do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:window_ids, field: :window_id)
             .register_column(:names, field: :name)
             .register_column(:descriptions, field: :description)
             .register_column(:enabled, field: :enabled)
             .register_column(:durations, field: :duration)
             .register_column(:cutoffs, field: :cutoff)
             .register_column(:schedules, field: :schedule)
             .register_column(:schedule_timezones, field: :schedule_timezone)
             .register_column(:schedule_offsets, field: :schedule_offset)
             .register_column(:end_dates, field: :end_date)
             .register_column(:start_dates, field: :start_date)
             .register_column(:next_execution_times, field: :next_execution_time)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.ssm_client.describe_maintenance_windows.map do |table|
        table.window_identities.map { |table_name| {
          window_id: table_name.window_id,
          name: table_name.name,
          description: table_name.description,
          enabled: table_name.enabled,
          duration: table_name.duration,
          cutoff: table_name.cutoff,
          schedule: table_name.schedule,
          schedule_timezone: table_name.schedule_timezone,
          schedule_offset: table_name.schedule_offset,
          end_date: table_name.end_date,
          start_date: table_name.start_date,
          next_execution_time: table_name.next_execution_time,
        }
        }
      end.flatten
    end
  end
end
