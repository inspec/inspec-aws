require 'aws_backend'

class AWSElasticLoadBalancingV2TargetGroups < AwsResourceBase
  name 'aws_elasticloadbalancingv2_target_groups'
  desc 'Describes the specified target groups or all of your target groups. By default, all target groups are described. Alternatively, you can specify one of the following to filter the results: the ARN of the load balancer, the names of one or more target groups, or the ARNs of one or more target groups.'

  example "
    describe aws_elasticloadbalancingv2_target_groups do
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
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_option= {}
    elastic_load_balancer_target_group = []
    pagination_option[:page_size] = 1

    loop do
      catch_aws_errors do
        @api_response  = @aws.elb_client_v2.describe_target_groups(pagination_option)
      end
      return elastic_load_balancer_target_group if !@api_response || @api_response.empty?

      @api_response.target_groups.each do |target_groups|
        elastic_load_balancer_target_group += [{
          target_group_arn:   target_groups.target_group_arn,
                                                 target_group_name:   target_groups.target_group_name,
                                                 protocol: target_groups.protocol,
                                                 port:    target_groups.port,
                                                 vpc_id: target_groups.vpc_id,
                                                 health_check_protocol:   target_groups.health_check_protocol,
                                                 health_check_port:   target_groups.health_check_port,
                                                 health_check_enabled: target_groups.health_check_enabled,
                                                 health_check_interval_seconds:    target_groups.health_check_interval_seconds,
                                                 health_check_timeout_seconds: target_groups.health_check_timeout_seconds,
                                                 healthy_threshold_count:   target_groups.healthy_threshold_count,
                                                 unhealthy_threshold_count:   target_groups.unhealthy_threshold_count,
                                                 health_check_path: target_groups.health_check_path,
                                                 matcher:    target_groups.matcher,
                                                 load_balancer_arns: target_groups.load_balancer_arns,
                                                 target_type:    target_groups.target_type,
                                                 protocol_version: target_groups.protocol_version,
        }]
      end
      break unless @api_response.next_marker
      pagination_option[:marker] = @api_response[:next_marker]
    end
    @table = elastic_load_balancer_target_group
  end
end
