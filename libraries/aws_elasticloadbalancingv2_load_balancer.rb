# frozen_string_literal: true

require 'aws_backend'

class AWSElasticLoadBalancingV2LoadBalancer < AwsResourceBase
  name 'aws_elasticloadbalancingv2_load_balancer'
  desc 'Returns information about the endpoints for your account in the current region.'

  example "
    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'test') do
      it { should exist }
    end
  "
  def initialize(opts = {})
    opts = { load_balancer_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:load_balancer_arn])
    raise ArgumentError, "#{@__resource_name__}: load_balancer_arn must be provided" unless opts[:load_balancer_arn] && !opts[:load_balancer_arn].empty?
    @display_name = opts[:listener_arn]
    catch_aws_errors do
      resp = @aws.elb_client_v2.describe_load_balancers({ load_balancer_arns: [opts[:load_balancer_arn]] })
      @load_balancers = resp.load_balancers[0].to_h
      create_resource_methods(@load_balancers)
    end
  end

  def id
    return nil unless exists?
    @load_balancers[:listener_arns]
  end

  def exists?
    !@load_balancers.nil? && !@load_balancers.empty?
  end

  def encrypted?
    @load_balancers[:encrypted]
  end

  def to_s
    "load_balancer_arn: #{@display_name}"
  end
end
