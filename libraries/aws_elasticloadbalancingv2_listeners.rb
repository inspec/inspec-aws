require "aws_backend"

class AWSElasticLoadBalancingV2Listeners < AwsResourceBase
  name "aws_elasticloadbalancingv2_listeners"
  desc "Lists the clients that have been created for the specified user pool."

  example "
    describe aws_elasticloadbalancingv2_listeners(load_balancer_arn: 'test1') do
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
    validate_parameters(required: %i(load_balancer_arn))

    raise ArgumentError, "#{@__resource_name__}: listener_arn must be provided" unless opts[:load_balancer_arn] && !opts[:load_balancer_arn].empty?

    @table = fetch_data
  end

  def fetch_data
    elastic_load_balancer_listener_row = []
    query_params = {}
    query_params[:load_balancer_arn] = opts[:load_balancer_arn]
    query_params[:page_size] = 100
    loop do
      catch_aws_errors do
        @resp = @aws.elb_client_v2.describe_listeners(query_params)
      end
      return elastic_load_balancer_listener_row if !@resp || @resp.empty?

      @resp.listeners.each do |listeners|
        elastic_load_balancer_listener_row += [{
          listener_arn:   listeners.listener_arn,
          load_balancer_arn:   listeners.load_balancer_arn,
          port: listeners.port,
          protocol:    listeners.protocol,
          certificates: listeners.certificates,
          ssl_policy:   listeners.ssl_policy,
          default_actions:   listeners.default_actions,
          alpn_policy: listeners.alpn_policy,
        }]
      end
      break unless @resp.next_marker
      query_params[:marker] = @resp.next_marker
    end
    @table =elastic_load_balancer_listener_row
  end
end
