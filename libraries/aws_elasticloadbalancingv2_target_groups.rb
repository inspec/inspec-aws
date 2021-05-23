# frozen_string_literal: true

require 'aws_backend'

class AWSElasticLoadBalancingV2TargetGroups < AwsResourceBase
  name 'aws_elasticloadbalancingv2_target_groups'
  desc 'Lists the clients that have been created for the specified user pool.'

  example "
    describe aws_elasticloadbalancingv2_target_groups(user_pool_id: 'test1') do
      its('count') { should eq 3 }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:target_group_arns,                                           field: :target_group_arn)
             .register_column(:target_group_names,                                          field: :target_group_name)
             .register_column(:protocols,                                                   field: :protocol)
             .register_column(:ports,                                                       field: :port)
             .register_column(:vpc_ids,                                                     field: :vpc_id)
             .register_column(:health_check_protocols,                                      field: :health_check_protocol)
             .register_column(:health_check_ports,                                          field: :health_check_port)
             .register_column(:health_check_enableds,                                       field: :health_check_enabled)
             .register_column(:health_check_interval_seconds,                               field: :health_check_interval_seconds)
             .register_column(:health_check_timeout_seconds,                                field: :health_check_timeout_seconds)
             .register_column(:healthy_threshold_counts,                                    field: :healthy_threshold_count)
             .register_column(:unhealthy_threshold_counts,                                  field: :unhealthy_threshold_count)
             .register_column(:health_check_paths,                                          field: :health_check_path)
             .register_column(:matchers,                                                    field: :matcher)
             .register_column(:load_balancer_arns,                                          field: :load_balancer_arns)
             .register_column(:target_types,                                                field: :target_type)
             .register_column(:protocol_versions,                                           field: :protocol_version)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(target_group_arns))
    @query_params = {}
    @query_params[:target_group_arns] = [opts[:target_group_arns]]
    if opts.key?(:target_group_arns)
      raise ArgumentError, "#{@__resource_name__}: target_group_arns must be provided" unless opts[:target_group_arns] && !opts[:target_group_arns].empty?
      @query_params[:target_group_arns] = [opts[:target_group_arns]]
    end
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.elb_client_v2.describe_target_groups(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.target_groups.map(&:to_h)
  end
end
