require 'aws_backend'

class AWSBatchComputeEnvironments < AwsResourceBase
  name 'aws_batch_compute_environments'
  desc 'Describes one or more of your compute environments.'
  example <<-EXAMPLE
    describe aws_batch_compute_environments do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:compute_environment_names,                       field: :compute_environment_name)
             .register_column(:compute_environment_arns,                        field: :compute_environment_arn)
             .register_column(:ecs_cluster_arns,                                field: :ecs_cluster_arn)
             .register_column(:tags,                                            field: :tags)
             .register_column(:types,                                           field: :type)
             .register_column(:states,                                          field: :state)
             .register_column(:statuses,                                        field: :status)
             .register_column(:status_reasons,                                  field: :status_reason)
             .register_column(:service_roles,                                   field: :service_role)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    compute_environment_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.batch_client.describe_compute_environments(pagination_options)
      end
      return compute_environment_rows if !@api_response || @api_response.empty?
      @api_response.compute_environments.each do |compute_environment|
        compute_environment_rows += [{
          compute_environment_name: compute_environment.compute_environment_name,
          compute_environment_arn: compute_environment.compute_environment_arn,
          ecs_cluster_arn: compute_environment.ecs_cluster_arn,
          tags: map_tags(compute_environment[:tags]),
          type: compute_environment.type,
          state: compute_environment.state,
          status: compute_environment.status,
          status_reason: compute_environment.status_reason,
          service_role: compute_environment.service_role,
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = compute_environment_rows
  end
end
