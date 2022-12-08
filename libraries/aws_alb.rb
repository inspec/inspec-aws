require "aws_backend"

class AwsAlb < AwsResourceBase
  name "aws_alb"
  desc "Verifies settings for an Application Load Balancer."

  example "
    describe aws_alb('arn:aws:elasticloadbalancing') do
      it { should exist }
    end

   describe aws_alb('arn:aws:elasticloadbalancing') do
    its('access_log_enabled') { should eq true }
    end
  "

  attr_reader :availability_zones, :canonical_hosted_zone_id, :created_time, :dns_name, :load_balancer_arn,
              :load_balancer_name, :load_balancer_addresses, :scheme, :security_groups, :state, :subnets, :type, :vpc_id,
              :zone_names

  def initialize(opts = {})
    opts = { load_balancer_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:load_balancer_arn])
    return unless alb

    @availability_zones = alb.availability_zones
    @canonical_hosted_zone_id = alb.canonical_hosted_zone_id
    @created_time = alb.created_time.to_s
    @dns_name = alb.dns_name
    @load_balancer_arn = alb.load_balancer_arn
    @load_balancer_name = alb.load_balancer_name
    @load_balancer_addresses = availability_zones.map(&:load_balancer_addresses).flatten
    @scheme = alb.scheme
    @security_groups = alb.security_groups
    @state = alb.state
    @subnets = availability_zones.map(&:subnet_id)
    @type = alb.type
    @vpc_id = alb.vpc_id
    @zone_names = availability_zones.map(&:zone_name)
  end

  def resource_id
    @load_balancer_arn
  end

  def access_log_enabled
    return unless alb_attributes
    s3_enabled_attr = alb_attributes.find { |attr| attr.key.eql?("access_logs.s3.enabled") }
    @access_log_enabled = s3_enabled_attr&.value == "true"
  end

  def listeners
    @listeners ||= catch_aws_errors do
      elb_client.describe_listeners(load_balancer_arn: opts[:load_balancer_arn]).listeners
    end
  end

  def ssl_policies
    @ssl_policies ||= listeners.filter_map { |listener| listener.ssl_policy if listener.protocol == "HTTPS" }.uniq
  end

  def external_ports
    @external_ports ||= listeners.map(&:port)
  end

  def protocols
    @protocols ||= listeners.map(&:protocol).uniq
  end

  def exists?
    !load_balancer_arn.nil?
  end

  def to_s
    "AWS ALB #{load_balancer_name}"
  end

  private

  def alb
    load_balancers&.first
  end

  def alb_attributes
    load_balancer_attributes&.attributes
  end

  def load_balancers
    @load_balancers ||= catch_aws_errors do
      elb_client.describe_load_balancers(load_balancer_arns: [opts[:load_balancer_arn]]).load_balancers
    end
  end

  def load_balancer_attributes
    @load_balancer_attributes ||= catch_aws_errors do
      elb_client.describe_load_balancer_attributes(load_balancer_arn: opts[:load_balancer_arn])
    end
  end

  def elb_client
    @aws.elb_client_v2
  end
end
