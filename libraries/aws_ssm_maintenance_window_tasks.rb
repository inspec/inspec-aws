require 'aws_backend'

class AWSSESMaintenanceWindowTasks < AwsResourceBase
  name 'aws_ssm_maintenance_window_tasks'
  desc 'Retrieves a task in the maintenance window.'

  example "
    describe aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:window_ids, field: :window_id)
             .register_column(:window_task_ids, field: :window_task_id)
             .register_column(:task_arns, field: :task_arn)
             .register_column(:types, field: :type)
             .register_column(:targets, field: :targets)
             .register_column(:task_parameters, field: :task_parameters)
             .register_column(:priorities, field: :priority)
             .register_column(:logging_infos, field: :logging_info)
             .register_column(:service_role_arns, field: :service_role_arn)
             .register_column(:max_concurrencies, field: :max_concurrency)
             .register_column(:max_errors, field: :max_errors)
             .register_column(:names, field: :name)
             .register_column(:descriptions, field: :description)
             .register_column(:cutoff_behaviors, field: :cutoff_behavior)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(window_id))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: window_id must be provided" unless opts[:window_id] && !opts[:window_id].empty?
    @query_params[:window_id] = opts[:window_id]
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.ssm_client.describe_maintenance_window_tasks(@query_params).map do |table|
        table.tasks.map { |table_name| {
          window_id: table_name.window_id,
          window_task_id: table_name.window_task_id,
          task_arn: table_name.task_arn,
          type: table_name.type,
          targets: table_name.targets,
          task_parameters: table_name.task_parameters,
          priority: table_name.priority,
          logging_info: table_name.logging_info,
          service_role_arn: table_name.service_role_arn,
          max_concurrency: table_name.max_concurrency,
          max_errors: table_name.max_errors,
          name: table_name.name,
          description: table_name.description,
          cutoff_behavior: table_name.cutoff_behavior,
        }
        }
      end.flatten
    end
  end
end
