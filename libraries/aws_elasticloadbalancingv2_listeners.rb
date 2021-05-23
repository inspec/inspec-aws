# frozen_string_literal: true

require 'aws_backend'

class AWSElasticLoadBalancingV2Listeners < AwsResourceBase
  name 'aws_elasticloadbalancingv2_listeners'
  desc 'Lists the clients that have been created for the specified user pool.'

  example "
    describe aws_elasticloadbalancingv2_listeners(listener_arn: 'test1') do
      its('count') { should eq 3 }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:listener_arns,                         field: :listener_arn)
             .register_column(:load_balancer_arns,                    field: :load_balancer_arn)
             .register_column(:ports,                                 field: :port)
             .register_column(:protocols,                             field: :protocol)
             .register_column(:certificates,                          field: :certificates)
             .register_column(:ssl_policies,                          field: :ssl_policy)
             .register_column(:default_actions,                       field: :default_actions)
             .register_column(:alpn_policies,                         field: :alpn_policy)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(listener_arn))
    @query_params = {}
    @query_params[:listener_arns] = [opts[:listener_arn]]
    if opts.key?(:listener_arn)
      raise ArgumentError, "#{@__resource_name__}: listener_arn must be provided" unless opts[:listener_arn] && !opts[:listener_arn].empty?
      @query_params[:listener_arns] = [opts[:listener_arn]]
    end
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.elb_client_v2.describe_listeners(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.listeners.map(&:to_h)
  end
end
