# frozen_string_literal: true

require 'aws_backend'

class AwsAlb < AwsResourceBase
  name 'aws_alb'
  desc 'Verifies settings for an Application Load Balancer'

  example "
    describe aws_alb('arn:aws:elasticloadbalancing') do
      it { should exist }
    end
  "

  attr_reader :availability_zones, :canonical_hosted_zone_id, :created_time, :dns_name, :load_balancer_arn,
              :load_balancer_name, :load_balancer_addresses, :scheme, :security_groups, :state, :subnets, :type, :vpc_id, :zone_names,
              :listeners, :ssl_policies, :external_ports, :protocols

  def initialize(opts = {})
    opts = { load_balancer_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:load_balancer_arn])

    catch_aws_errors do
      load_balancer_arns = { load_balancer_arns: [opts[:load_balancer_arn]] }
      resp = @aws.elb_client_v2.describe_load_balancers(load_balancer_arns)
      return nil if resp.load_balancers.nil? || resp.load_balancers.empty?
      alb = resp.load_balancers.first
      @availability_zones       = alb.availability_zones
      @zone_names               = @availability_zones.map(&:zone_name)
      @subnets                  = @availability_zones.map(&:subnet_id)
      @load_balancer_addresses  = @availability_zones.map(&:load_balancer_addresses).flatten
      @canonical_hosted_zone_id = alb.canonical_hosted_zone_id
      @created_time             = alb.created_time.to_s
      @dns_name                 = alb.dns_name
      @load_balancer_arn        = alb.load_balancer_arn
      @load_balancer_name       = alb.load_balancer_name
      @security_groups          = alb.security_groups
      @scheme                   = alb.scheme
      @state                    = alb.state
      @type                     = alb.type
      @vpc_id                   = alb.vpc_id

      @listeners      = @aws.elb_client_v2.describe_listeners(load_balancer_arn: opts[:load_balancer_arn]).listeners
      @ssl_policies   = @listeners.select { |l| l.protocol == 'HTTPS' }.map(&:ssl_policy).uniq
      @external_ports = @listeners.map(&:port)
      @protocols      = @listeners.map(&:protocol).uniq
    end
  end

  def exists?
    !@load_balancer_arn.nil?
  end

  def to_s
    "AWS ALB #{@load_balancer_name}"
  end
end
