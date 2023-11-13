require 'aws_backend'

class AwsEcsCluster < AwsResourceBase
  name 'aws_ecs_cluster'
  desc 'Verifies settings for an ECS cluster.'

  example "
    describe aws_ecs_cluster('backup-cluster') do
      it { should exist }
    end
  "

  attr_reader :cluster_arn, :cluster_name, :status,
              :registered_container_instances_count, :running_tasks_count,
              :pending_tasks_count, :active_services_count, :statistics

  def initialize(opts = {})
    opts = { cluster_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(allow: [:cluster_name])

    catch_aws_errors do
      # If no params are passed we attempt to get the 'default' cluster.
      cluster = opts.nil? ? {} : { clusters: [opts[:cluster_name]] }
      resp = @aws.ecs_client.describe_clusters(cluster).clusters[0]

      return if !resp || resp.empty?

      @status       = resp.status
      @statistics   = resp.statistics
      @cluster_arn  = resp.cluster_arn
      @cluster_name = resp.cluster_name
      @running_tasks_count    = resp.running_tasks_count
      @pending_tasks_count    = resp.pending_tasks_count
      @active_services_count  = resp.active_services_count
      @registered_container_instances_count = resp.registered_container_instances_count
    end
  end

  def resource_id
    @cluster_arn
  end

  def exists?
    !@cluster_arn.nil?
  end

  def to_s
    "AWS ECS cluster #{cluster_name}"
  end
end
