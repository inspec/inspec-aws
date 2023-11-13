require 'aws_backend'

class AWSElasticLoadBalancingV2Listener < AwsResourceBase
  name 'aws_elasticloadbalancingv2_listener'
  desc 'Returns information about the endpoints for your account in the current region.'

  example "
    describe aws_elasticloadbalancingv2_listener(listener_arn: 'test') do
      it { should exist }
    end
  "
  def initialize(opts = {})
    opts = { listener_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:listener_arn])
    raise ArgumentError, "#{@__resource_name__}: listener_arn must be provided" unless opts[:listener_arn] && !opts[:listener_arn].empty?
    @display_name = opts[:listener_arn]
    catch_aws_errors do
      resp = @aws.elb_client_v2.describe_listeners({ listener_arns: [opts[:listener_arn]] })
      @listeners = resp.listeners[0].to_h
      create_resource_methods(@listeners)
    end
  end

  def listener_arn
    return unless exists?
    @listeners[:listener_arns]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@listeners.nil? && !@listeners.empty?
  end

  def to_s
    "Listener ARN: #{@display_name}"
  end
end
