# frozen_string_literal: true

require 'aws_backend'

class AWSElasticLoadBalancingV2LoadBalancers < AwsResourceBase
  name 'aws_elasticloadbalancingv2_load_balancers'
  desc 'Describes the specified load balancers or all of your load balancers.'

  example "
    describe aws_elasticloadbalancingv2_load_balancers do
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
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    elastic_load_balancer_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response  = @aws.elb_client_v2.describe_load_balancers(pagination_options)
      end
      return elastic_load_balancer_rows if !@api_response || @api_response.empty?

      @api_response.load_balancers.each do |load_balancers|
        elastic_load_balancer_rows += [{         load_balancer_arn: load_balancers.load_balancer_arn,
                                                 dns_name: load_balancers.dns_name,
                                                 canonical_hosted_zone_id: load_balancers.canonical_hosted_zone_id,
                                                 created_times: load_balancers.created_time,
                                                 load_balancer_name: load_balancers.load_balancer_name,
                                                 security_groups: load_balancers.security_groups,
                                                 state: load_balancers.state,
                                                 scheme: load_balancers.scheme,
                                                 vpc_id: load_balancers.vpc_id,
                                                 type: load_balancers.type,
                                                 availability_zones: load_balancers.availability_zones,
                                                 ip_address_types: load_balancers.ip_address_type,
                                                 customer_owned_ipv_4_pool: load_balancers.customer_owned_ipv_4_pool }]
      end
      break unless @api_response.next_marker
      pagination_options = { next_marker: @api_response[:next_marker] }
    end
    @table = elastic_load_balancer_rows
  end
end
