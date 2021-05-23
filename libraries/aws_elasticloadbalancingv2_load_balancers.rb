# frozen_string_literal: true

require 'aws_backend'

class AWSElasticLoadBalancingV2LoadBalancers < AwsResourceBase
  name 'aws_elasticloadbalancingv2_load_balancers'
  desc 'Lists the clients that have been created for the specified user pool.'

  example "
    describe _aws_elasticloadbalancingv2_load_balancers(user_pool_id: 'test1') do
      its('count') { should eq 3 }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:load_balancer_arns,                                field: :load_balancer_arn)
             .register_column(:dns_names,                                         field: :dns_name)
             .register_column(:canonical_hosted_zone_ids,                         field: :canonical_hosted_zone_id)
             .register_column(:created_times,                                     field: :created_time)
             .register_column(:load_balancer_names,                               field: :load_balancer_name)
             .register_column(:schemes,                                           field: :scheme)
             .register_column(:vpc_ids,                                           field: :vpc_id)
             .register_column(:states,                                            field: :state)
             .register_column(:types,                                             field: :type)
             .register_column(:availability_zones,                                field: :availability_zones)
             .register_column(:security_groups,                                   field: :security_groups)
             .register_column(:ip_address_types,                                  field: :ip_address_type)
             .register_column(:customer_owned_ipv_4_pools,                        field: :customer_owned_ipv_4_pool)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(load_balancer_arn))
    @query_params = {}
    @query_params[:load_balancer_arns] = [opts[:load_balancer_arn]]
    if opts.key?(:file_system_id)
      raise ArgumentError, "#{@__resource_name__}: load_balancer_arn must be provided" unless opts[:load_balancer_arn] && !opts[:load_balancer_arn].empty?
      @query_params[:load_balancer_arns] = [opts[:load_balancer_arn]]
    end
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.elb_client_v2.describe_load_balancers(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.load_balancers.map(&:to_h)
  end
end
