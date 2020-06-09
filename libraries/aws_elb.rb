# frozen_string_literal: true

require 'aws_backend'

class AwsElb < AwsResourceBase
  name 'aws_elb'
  desc 'Verifies settings for an Elastic Load Balancer'

  example "
    describe aws_elb('load-balancer-1') do
      it { should exist }
    end
  "

  attr_reader :availability_zones, :dns_name, :load_balancer_name, :external_ports,
              :instance_ids, :internal_ports, :security_group_ids,
              :subnet_ids, :vpc_id, :listeners, :ssl_policies, :protocols

  def initialize(opts = {})
    opts = { load_balancer_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:load_balancer_name])

    catch_aws_errors do
      load_balancer_name = { load_balancer_names: [opts[:load_balancer_name]] }
      resp = @aws.elb_client.describe_load_balancers(load_balancer_name).load_balancer_descriptions.first

      @availability_zones = resp.availability_zones
      @dns_name           = resp.dns_name
      @load_balancer_name = resp.load_balancer_name
      @listeners          = resp.listener_descriptions
      @external_ports     = resp.listener_descriptions.map { |l| l.listener.load_balancer_port }
      @instance_ids       = resp.instances.map(&:instance_id)
      @internal_ports     = resp.listener_descriptions.map { |l| l.listener.instance_port }
      @security_group_ids = resp.security_groups
      @subnet_ids         = resp.subnets
      @vpc_id             = resp.vpc_id
      @protocols          = resp.listener_descriptions.map { |l| l.listener.protocol }.uniq

      # The ELB will list multiple custom policies, including previously configured policies
      # Even if a pre-defined policy is selected, a custom policy is created from that template
      # So, we need to get a list of all policies currently in use and filter the list of policies that exist
      policies_in_use     = resp.listener_descriptions.map(&:policy_names).flatten.uniq
      @ssl_policies       = @aws.elb_client.describe_load_balancer_policies(load_balancer_name: opts[:load_balancer_name])
                                .policy_descriptions.select { |p| policies_in_use.include?(p.policy_name) }
    end
  end

  def exists?
    !@vpc_id.nil?
  end

  def to_s
    "AWS ELB #{load_balancer_name}"
  end
end
