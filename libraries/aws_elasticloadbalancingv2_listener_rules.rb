# frozen_string_literal: true

require 'aws_backend'

class AWSElasticLoadBalancingV2ListenerRules < AwsResourceBase
  name 'aws_elasticloadbalancingv2_listener_rules'
  desc 'Lists the clients that have been created for the specified user pool.'

  example "
    describe aws_elasticloadbalancingv2_listener_rules(user_pool_id: 'test1') do
      its('count') { should eq 3 }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:rule_arns,                               field: :rule_arn)
             .register_column(:priorities,                              field: :priority)
             .register_column(:conditions,                              field: :conditions)
             .register_column(:actions,                                 field: :actions)
             .register_column(:is_defaults,                             field: :is_default)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rule_arns))
    @query_params = {}
    @query_params[:rule_arns] = [opts[:rule_arns]]
    if opts.key?(:rule_arns)
      raise ArgumentError, "#{@__resource_name__}: rule_arns must be provided" unless opts[:rule_arns] && !opts[:rule_arns].empty?
      @query_params[:rule_arns] = [opts[:rule_arns]]
    end
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.elb_client_v2.describe_rules(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.rules.map(&:to_h)
  end
end
