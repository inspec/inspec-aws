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
              :subnet_ids, :vpc_id

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
      @external_ports     = resp.listener_descriptions.map { |l| l.listener.load_balancer_port }
      @instance_ids       = resp.instances.map(&:instance_id)
      @internal_ports     = resp.listener_descriptions.map { |l| l.listener.instance_port }
      @security_group_ids = resp.security_groups
      @subnet_ids         = resp.subnets
      @vpc_id             = resp.vpc_id
    end
  end

  def exists?
    !@vpc_id.nil?
  end

  def to_s
    "AWS ELB #{load_balancer_name}"
  end
end
