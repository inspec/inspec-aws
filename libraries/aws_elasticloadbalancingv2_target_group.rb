require "aws_backend"

class AWSElasticLoadBalancingV2TargetGroup < AwsResourceBase
  name "aws_elasticloadbalancingv2_target_group"
  desc "Describes the specified target groups or all of your target groups. By default, all target groups are described. Alternatively, you can specify one of the following to filter the results: the ARN of the load balancer, the names of one or more target groups, or the ARNs of one or more target groups."

  example "
    describe aws_elasticloadbalancingv2_target_group(target_group_arn: 'test-arn') do
      it { should exist }
    end
  "
  def initialize(opts = {})
    opts = { target_group_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:target_group_arn])
    unless opts[:target_group_arn] && !opts[:target_group_arn].empty?
      raise ArgumentError,
            "#{@__resource_name__}: target_group_arns must be provided"
    end
    @display_name = opts[:target_group_arn]
    catch_aws_errors do
      resp =
        @aws.elb_client_v2.describe_target_groups(
          { target_group_arns: [opts[:target_group_arn]] }
        )
      @target_groups = resp.target_groups[0].to_h
      create_resource_methods(@target_groups)
    end
  end

  def target_group_arn
    return nil unless exists?
    @target_groups[:target_group_arn]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@target_groups.nil? && !@target_groups.empty?
  end

  def to_s
    "Target Group ARN: #{@display_name}"
  end
end
