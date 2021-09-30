# frozen_string_literal: true

require 'aws_backend'

class AWSCloudFormationStackSets < AwsResourceBase
  name 'aws_cloud_formation_stack_sets'
  desc 'Describes all the specified stack set.'
  example "
    describe aws_cloud_formation_stack_sets do
      it { should exist }
    end
  "

  attr_reader :table

  def initialize(opts = {})
    # Call the parent class constructor
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  FilterTable.create
             .register_column(:stack_set_names, field: :stack_set_name)
             .register_column(:stack_set_ids, field: :stack_set_id)
             .register_column(:descriptions, field: :description)
             .register_column(:statuses, field: :status)
             .register_column(:permission_models, field: :permission_model)
             .register_column(:drift_statuses, field: :drift_status)
             .register_column(:last_drift_check_timestamps, field: :last_drift_check_timestamp)
             .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @cloudwatch_dashboards = @aws.cloudwatch_client.list_dashboards.map do |dashboards|
        dashboards.dashboard_entries.map { |cloudwatch_dashboards| {
          stack_set_name: cloudwatch_dashboards[:stack_set_name],
          stack_set_id: cloudwatch_dashboards[:stack_set_id],
          description: cloudwatch_dashboards[:description],
          status: cloudwatch_dashboards[:status],
          permission_model: cloudwatch_dashboards[:permission_model],
          drift_status: cloudwatch_dashboards[:drift_status],
          last_drift_check_timestamp: cloudwatch_dashboards[:last_drift_check_timestamp],
        }
        }
      end.flatten
    end
  end
end
