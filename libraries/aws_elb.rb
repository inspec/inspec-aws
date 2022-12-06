require 'aws_backend'

class AwsElb < AwsResourceBase
  name 'aws_elb'
  desc 'Verifies settings for an Elastic Load Balancer.'

  example "
    describe aws_elb('load-balancer-1') do
      it { should exist }
    end
  "

  attr_reader :availability_zones, :dns_name, :load_balancer_name, :external_ports,
              :instance_ids, :internal_ports, :security_group_ids,
              :subnet_ids, :vpc_id, :listeners, :protocols, :certificate_id

  def initialize(opts = {})
    opts = { load_balancer_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:load_balancer_name])
    @availability_zones = load_balancer_description.availability_zones
    @dns_name           = load_balancer_description.dns_name
    @load_balancer_name = load_balancer_description.load_balancer_name
    @external_ports     = load_balancer_description.listener_descriptions.map { |l| l.listener.load_balancer_port }
    @instance_ids       = load_balancer_description.instances.map(&:instance_id)
    @internal_ports     = load_balancer_description.listener_descriptions.map { |l| l.listener.instance_port }
    @security_group_ids = load_balancer_description.security_groups
    @subnet_ids         = load_balancer_description.subnets
    @vpc_id             = load_balancer_description.vpc_id
    @listeners          = load_balancer_description.listener_descriptions
    @protocols          = load_balancer_description.listener_descriptions.map { |l| l.listener.protocol }.uniq
    @certificate_id     = load_balancer_description.listener_descriptions.map { |l| l.listener.ssl_certificate_id }
  end

  def exists?
    !load_balancer_description.nil?
  end

  def to_s
    "AWS ELB #{load_balancer_name}"
  end

  def cross_zone_load_balancing_enabled?
    !!load_balancer_attributes.cross_zone_load_balancing.enabled
  end

  def access_log_enabled?
    !!load_balancer_attributes.access_log.enabled
  end

  def ssl_policies
    @ssl_policies ||= catch_aws_errors do
      elb_client.describe_load_balancer_policies(load_balancer_name: opts[:load_balancer_name])
                .policy_descriptions.select { |p| policies_in_use.include?(p.policy_name) }
    end
  end

  def resource_id
    @load_balancer_description? "#{@load_balancer_name}_#{@load_balancer_description[:availability_zones]}" : ''
  end

  private

  def load_balancer_description
    @load_balancer_description ||= catch_aws_errors do
      elb_client.describe_load_balancers(load_balancer_names: [opts[:load_balancer_name]]).load_balancer_descriptions.first
    end
  end

  def load_balancer_attributes
    @load_balancer_attributes ||= catch_aws_errors do
      elb_client.describe_load_balancer_attributes(load_balancer_name: opts[:load_balancer_name]).load_balancer_attributes
    end
  end

  # The ELB will list multiple custom policies, including previously configured policies
  # Even if a pre-defined policy is selected, a custom policy is created from that template
  # So, we need to get a list of all policies currently in use and filter the list of policies that exist
  def policies_in_use
    load_balancer_description.listener_descriptions.flat_map(&:policy_names).uniq
  end

  def elb_client
    @aws.elb_client
  end
end
