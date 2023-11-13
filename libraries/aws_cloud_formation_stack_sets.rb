require 'aws_backend'

class AWSCloudFormationStackSets < AwsResourceBase
  name 'aws_cloud_formation_stack_sets'
  desc 'Describes all the specified stack set.'
  example <<-EXAMPLE
    describe aws_cloud_formation_stack_sets do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  FilterTable.create
             .register_column(:stack_set_names, field: :stack_set_name)
             .register_column(:stack_set_ids, field: :stack_set_id)
             .register_column(:descriptions, field: :description)
             .register_column(:statuses, field: :status)
             .register_column(:auto_deployments, field: :auto_deployment)
             .register_column(:permission_models, field: :permission_model)
             .register_column(:drift_statuses, field: :drift_status)
             .register_column(:last_drift_check_timestamps, field: :last_drift_check_timestamp)
             .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @resp = @aws.cloudformation_client.list_stack_sets.map do |table|
        table.summaries.map { |table_name| {
          stack_set_name: table_name[:stack_set_name],
          stack_set_id: table_name[:stack_set_id],
          description: table_name[:description],
          status: table_name[:status],
          auto_deployment: table_name[:auto_deployment],
          permission_model: table_name[:permission_model],
          drift_status: table_name[:drift_status],
          last_drift_check_timestamp: table_name[:last_drift_check_timestamp],
        }
        }
      end.flatten
    end
  end
end
