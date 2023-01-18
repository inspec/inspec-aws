require "aws_backend"

class AWSECSServices < AwsResourceBase
  name "aws_ecs_services"
  desc "Lists the services that are running in a specified cluster."

  example "
    describe aws_ecs_services(cluster: 'cluster_name') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:service_arns,      field: :service_arn)
    .register_column(:service_names,     field: :service_name)
    .register_column(:cluster_arns,      field: :cluster_arn)
    .register_column(:status,            field: :status)
    .register_column(:desired_count,     field: :desired_count)
    .register_column(:running_count,     field: :running_count)
    .register_column(:pending_count,     field: :pending_count)
    .register_column(:launch_types,      field: :launch_type)
    .register_column(:task_definitions,  field: :task_definition)
    .register_column(:platform_versions, field: :platform_version)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(allow: %i(cluster))
    query_params = {}

    if opts.key?(:cluster)
      query_params[:cluster] = opts[:cluster]
    end
    @table = fetch_data(query_params)
  end

  def fetch_data(query_params)
    service_rows = []
    service_ids = {}
    service_details = {}
    query_params[:max_results] = 10
    params = {}
    if opts.key?(:cluster)
      params[:cluster] = opts[:cluster]
    end
    loop do
      catch_aws_errors do

        service_ids = @aws.ecs_client.list_services(query_params)

      end
      return service_rows if !service_ids || service_ids.empty?

      catch_aws_errors do
        params[:services]=service_ids[:service_arns]
        service_details = @aws.ecs_client.describe_services(params)
      end

      service_details.services.each do |c|
        service_rows += [{
          service_arn:                          c.service_arn,
          service_name:                         c.service_name,
          cluster_arn:                          c.cluster_arn,
          status:                               c.status,
          desired_count:                        c.desired_count,
          running_count:                        c.running_count,
          pending_count:                        c.pending_count,
          launch_type:                          c.launch_type,
          task_definition:                      c.task_definition,
          platform_version:                     c.platform_version,
        }]
      end
      break unless service_ids.next_token
      @query_params[:next_token] = service_ids.next_token
    end
    @table = service_rows
  end
end
