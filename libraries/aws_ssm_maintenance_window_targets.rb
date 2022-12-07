require 'aws_backend'

class AWSSESMaintenanceWindowTargets < AwsResourceBase
  name 'aws_ssm_maintenance_window_targets'
  desc 'Lists the targets registered with the maintenance window.'

  example "
    describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:window_ids, field: :window_id)
             .register_column(:window_target_ids, field: :window_target_id)
             .register_column(:resource_types, field: :resource_type)
             .register_column(:targets, field: :targets)
             .register_column(:owner_informations, field: :owner_information)
             .register_column(:names, field: :name)
             .register_column(:descriptions, field: :description)
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
      @table = @aws.ssm_client.describe_maintenance_window_targets(@query_params).map do |table|
        table.targets.map { |table_name| {
          window_id: table_name.window_id,
          window_target_id: table_name.window_target_id,
          resource_type: table_name.resource_type,
          targets: table_name.targets,
          owner_information: table_name.owner_information,
          name: table_name.name,
          description: table_name.description,
        }
        }
      end.flatten
    end
  end
end
