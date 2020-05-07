# frozen_string_literal: true

require 'aws_backend'

class AwsEc2Instance < AwsResourceBase
  name 'aws_ec2_instance'
  desc 'Verifies settings for an AWS EC2 instance'

  example "
    describe aws_ec2_instance('i-123456') do
      it { should be_running }
      it { should have_roles }
    end

    describe aws_ec2_instance(name: 'my-instance') do
      it { should be_running }
      it { should have_roles }
    end
  "

  def initialize(opts = {})
    opts = { instance_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(instance_id name))

    if opts[:instance_id] && !opts[:instance_id].empty? # Use instance_id, if provided
      if !opts[:instance_id].is_a?(String) || opts[:instance_id] !~ /^i\-([0-9a-f]{8})|(^i\-[0-9a-f]{17})$/
        raise ArgumentError, "#{@__resource_name__}: `instance_id` must be a string in the format of 'i-' followed by 8 or 17 hexadecimal characters."
      end
      @display_name = opts[:instance_id]
      instance_arguments = { instance_ids: [opts[:instance_id]] }
    elsif opts[:name] && !opts[:name].empty? # Otherwise use name, if provided
      raise ArgumentError, "#{@__resource_name__}: `name` must be provided" if opts[:name].nil? || opts[:name].empty?
      @display_name = opts[:name] || opts[:instance_id]
      instance_arguments = { filters: [{ name: 'tag:Name', values: [opts[:name]] }] }
    else
      raise ArgumentError, "#{@__resource_name__}: either instance_id or name must be provided"
    end

    catch_aws_errors do
      @resp = @aws.compute_client.describe_instances(instance_arguments)
      if @resp.reservations.first.nil? || @resp.reservations.first.instances.first.nil?
        return
      end
      if @resp.reservations.first.instances.count > 1
        fail_resource('Multiple EC2 instances were returned for the provided criteria.
                       If you wish to test multiple entities, please use the aws_ec2_instances resource.
                       Otherwise, please provide more specific criteria to lookup your EC2 Instance.')
      else
        @instance = @resp.reservations.first.instances.first.to_h unless @resp.reservations.first.nil? || @resp.reservations.first.instances.first.nil?
      end

      create_resource_methods(@instance)

      # Methods required to ensure backwards compatibility
      class << self
        def state
          return nil unless @instance[:state]
          @instance[:state][:name]
        end

        def security_groups
          @instance[:security_groups].map { |sg| { id: sg[:group_id], name: sg[:group_name] } }
        end

        def tags
          @instance[:tags].map { |tag| { key: tag[:key], value: tag[:value] } }
        end
      end
    end
  end

  def exists?
    !@instance.nil? && !@instance.empty?
  end

  def security_group_ids
    return nil unless @instance[:security_groups]
    @instance[:security_groups].map { |sg| sg[:group_id] }
  end

  def availability_zone
    return nil unless @instance[:placement]
    return nil unless @instance[:placement].include?(:availability_zone)
    @instance[:placement][:availability_zone]
  end

  def ebs_volumes
    return nil unless @instance[:block_device_mappings]
    return nil if @instance[:block_device_mappings].count.zero?
    @instance[:block_device_mappings].map { |vol| { id: vol[:ebs][:volume_id], name: vol[:device_name] } }
  end

  def network_interface_ids
    return nil unless @instance[:network_interfaces]
    return nil if @instance[:network_interfaces].count.zero?
    @instance[:network_interfaces].map { |nic| nic[:network_interface_id] }
  end

  def has_roles?
    return false unless @instance[:iam_instance_profile] && @instance[:iam_instance_profile][:arn]
    instance_profile = @instance[:iam_instance_profile][:arn].split('/').last
    returned_roles = nil
    catch_aws_errors do
      resp = @aws.iam_client.get_instance_profile({ instance_profile_name: instance_profile })
      returned_roles = resp.instance_profile.roles
    end
    returned_roles && !returned_roles.empty?
  end

  # Generate a matcher for each state
  %w{pending running shutting-down terminated stopping stopped unknown}.each do |state_name|
    define_method state_name.tr('-', '_') + '?' do
      state == state_name
    end
  end

  def to_s
    "EC2 Instance #{@display_name}"
  end

  def tags_hash
    return unless exists?
    map_tags(tags)
  end
end
