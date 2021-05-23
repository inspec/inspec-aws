# frozen_string_literal: true

require 'aws_backend'

class AWSElasticLoadBalancingV2TargetGroup < AwsResourceBase
  name 'aws_elasticloadbalancingv2_target_group'
  desc 'Returns information about the endpoints for your account in the current region.'

  example "
    describe aws_elasticloadbalancingv2_target_group(target_group_arns: 'test') do
      it { should exist }
    end
  "
  def initialize(opts = {})
    opts = { target_group_arns: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:target_group_arns])
    raise ArgumentError, "#{@__resource_name__}: target_group_arns must be provided" unless opts[:target_group_arns] && !opts[:target_group_arns].empty?
    @display_name = opts[:target_group_arns]
    catch_aws_errors do
      resp = @aws.elb_client_v2.describe_target_groups({ target_group_arns: [opts[:target_group_arns]] })
      @target_groups = resp.target_groups[0].to_h
      create_resource_methods(@target_groups)
    end
  end

  def id
    return nil unless exists?
    @target_groups[:target_group_arns]
  end

  def exists?
    !@target_groups.nil? && !@target_groups.empty?
  end

  def encrypted?
    @target_groups[:encrypted]
  end

  def to_s
    "target_group_arns: #{@display_name}"
  end
end
