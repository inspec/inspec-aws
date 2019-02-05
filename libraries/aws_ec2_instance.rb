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
    # Call the parent class constructor
    raise ArgumentError, 'aws_ec2_instance `instance_id` or `name` must be provided' if opts.nil?
    opts = { instance_id: opts } if opts.is_a?(String) # this preserves the original scalar interface - note that the original implementation offered scalar 'id' or tag property :name
    super(opts)
    validate_parameters(%i(instance_id name))
    @display_name = opts[:name] || opts[:instance_id]
    if opts[:instance_id] && !opts[:instance_id].empty? # we either use the instance_id
      raise ArgumentError, 'aws_ec2_instance `instance_id` must be a string' if !opts[:instance_id].is_a?(String)
      raise ArgumentError, 'aws_ec2_instance `instance_id`  must be in the format "i-" followed by 8 or 17 hexadecimal characters.' if opts[:instance_id] !~ /^i\-([0-9a-f]{8})|(^i\-[0-9a-f]{17})$/
      instance_arguments = { instance_ids: [opts[:instance_id]] }
    else # or use the tag naming convention
      raise ArgumentError, 'aws_ec2_instance `name` must be provided' if opts[:name].nil? || opts[:name].empty?
      filter = { name: 'tag:Name', values: [opts[:name]] }
      instance_arguments = { filters: [filter] }
    end

    catch_aws_errors do
      @resp = @aws.compute_client.describe_instances(instance_arguments)
      @instance = @resp.reservations.first.instances.first.to_h unless @resp.reservations.first.nil? || @resp.reservations.first.instances.first.nil?
      # TODO: review whether filtering by name is useful
      if !@instance.nil?
        raise Inspec::Exceptions::ResourceFailed, 'Expected only one instance to be returned when filtering by name!' if @resp.reservations.first.instances.count > 1
      end
      create_resource_methods(@instance)
      # below is because the original implementation exposed several clashing method
      # names and we want to ensure backwards compatibility
      class << self
        def state
          return nil if !@instance[:state]
          @instance[:state][:name]
        end

        def security_groups
          @instance[:security_groups].map { |sg|
            { id: sg[:group_id], name: sg[:group_name] }
          }
        end

        def tags
          @instance[:tags].map { |tag| { key: tag[:key], value: tag[:value] } }
        end
      end
    end
  end

  def exists?
    return false if !@instance
    !@instance.empty?
  end

  def security_group_ids
    return nil if !@instance[:security_groups]
    @instance[:security_groups].map { |sg| sg[:group_id] }
  end

  def availability_zone
    return nil if !@instance[:placement]
    return nil if !@instance[:placement].include?(:availability_zone)
    @instance[:placement][:availability_zone]
  end

  def ebs_volumes
    return nil if !@instance[:block_device_mappings]
    return nil if @instance[:block_device_mappings].count.zero?
    @instance[:block_device_mappings].map { |vol| { id: vol[:ebs][:volume_id], name: vol[:device_name] } }
  end

  def network_interface_ids
    return nil if !@instance[:network_interfaces]
    return nil if @instance[:network_interfaces].count.zero?
    @instance[:network_interfaces].map { |nic| nic[:network_interface_id] }
  end

  def has_roles?
    return false if !@instance[:iam_instance_profile]
    return false if !@instance[:iam_instance_profile][:arn]
    instance_profile = @instance[:iam_instance_profile][:arn].split('/').last
    returned_roles = nil
    catch_aws_errors do
      @resp = @aws.iam_client.get_instance_profile({ instance_profile_name: instance_profile })
      returned_roles = @resp.instance_profile.roles
    end
    returned_roles && !returned_roles.empty?
  end

  # additional helper methods for each state
  %w{
    pending running shutting-down
    terminated stopping stopped unknown
  }.each do |state_name|
    define_method state_name.tr('-', '_') + '?' do
      state == state_name
    end
  end

  def to_s
    "EC2 Instance #{@display_name}"
  end
end
