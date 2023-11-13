require 'aws_backend'

class AwsEcsClusters < AwsResourceBase
  name 'aws_ecs_clusters'
  desc 'Verifies settings for a collection AWS ECS Clusters.'
  example "
    describe aws_ecs_clusters do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:cluster_arns,           field: :cluster_arn)
             .register_column(:cluster_names,          field: :cluster_name)
             .register_column(:statuses,               field: :status)
             .register_column(:running_tasks_counts,   field: :running_tasks_count)
             .register_column(:pending_tasks_counts,   field: :pending_tasks_count)
             .register_column(:active_services_counts, field: :active_services_count)
             .register_column(:statistics,             field: :statistics)
             .register_column(:registered_container_instances_counts, field: :registered_container_instances_count)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    cluster_rows = []
    cluster_ids = {}
    pagination_options = {}
    cluster_details = {}

    loop do
      catch_aws_errors do
        cluster_ids = @aws.ecs_client.list_clusters(pagination_options)
      end
      return [] if !cluster_ids || cluster_ids.empty?

      catch_aws_errors do
        cluster_details = @aws.ecs_client.describe_clusters(clusters: cluster_ids[:cluster_arns])
      end

      cluster_details.clusters.map do |c|
        cluster_rows += [{ cluster_arn:             c.cluster_arn,
                           cluster_name:            c.cluster_name,
                           status:                  c.status,
                           running_tasks_count_id:  c.running_tasks_count,
                           pending_tasks_count:     c.pending_tasks_count,
                           active_services_count:   c.active_services_count,
                           statistics:              c.statistics,
                           registered_container_instances_count: c.registered_container_instances_count }]
      end
      break unless cluster_ids.next_token
      pagination_options = { next_token: cluster_ids.next_token }
    end
    @table = cluster_rows
  end
end
