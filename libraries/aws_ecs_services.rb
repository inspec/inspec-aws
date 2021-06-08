# frozen_string_literal: true

require 'aws_backend'

class AWSECSServices < AwsResourceBase
  name 'aws_ecs_services'
  desc 'Lists the services that are running in a specified cluster.'

  example "
    describe aws_ecs_services(cluster: 'cluster_name') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:service_arns,      field: :service_arns)
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
    validate_parameters(required: %i(cluster))
    if opts.key?(:cluster)
      raise ArgumentError, "#{@__resource_name__}: cluster must be provided" unless opts[:cluster] && !opts[:cluster].empty?
    end
    @table = fetch_data
  end

  def fetch_data
    service_rows = []
    service_ids = {}
    pagination_options ={ cluster: opts[:cluster] }
    service_details = {}

    loop do
      catch_aws_errors do
        service_ids = @aws.ecs_client.list_services(pagination_options)
      end
      return [] if !service_ids || service_ids.empty?

      catch_aws_errors do
        service_details = @aws.ecs_client.describe_services({cluster: opts[:cluster] , services: service_ids[:service_arns] })
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
      pagination_options = { cluster: opts[:cluster], next_token: service_ids.next_token }
    end
    @table = service_rows

  end

end
