require 'aws_backend'

class AWSElasticLoadBalancingV2ListenerRules < AwsResourceBase
  name 'aws_elasticloadbalancingv2_listener_rules'
  desc 'Describes the specified rules or the rules for the specified listener. You must specify either a listener or one or more rules.'

  example "
    describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'test1') do
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
    validate_parameters(required: %i(listener_arn))
    @query_params = {}
    @query_params[:listener_arn] = opts[:listener_arn]
    if opts.key?(:listener_arn)
      raise ArgumentError, "#{@__resource_name__}: rule_arns must be provided" unless opts[:listener_arn] && !opts[:listener_arn].empty?
      @query_params[:listener_arn] = opts[:listener_arn]
    end
    @table = fetch_data
  end

  def fetch_data
    elastic_load_balancer_listener_rows = []
    @query_params[:page_size] = 100
    loop do
      catch_aws_errors do
        @api_response  = @aws.elb_client_v2.describe_rules(@query_params)
      end
      return elastic_load_balancer_listener_rows if !@api_response || @api_response.empty?

      @api_response.rules.each do |rules|
        elastic_load_balancer_listener_rows += [{
          rule_arn: rules.rule_arn,
          priority: rules.priority,
          conditions: rules.conditions,
          actions: rules.actions,
          is_default: rules.is_default,
        }]
      end
      break unless @api_response.next_marker
      @query_params[:marker] = @api_response[:next_marker]
    end
    @table = elastic_load_balancer_listener_rows
  end
end
