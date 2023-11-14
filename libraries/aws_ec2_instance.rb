require "aws_backend"

class AwsEc2Instance < AwsResourceBase
  name "aws_ec2_instance"
  desc "Verifies settings for an AWS EC2 instance."

  example "
    describe aws_ec2_instance('i-12345678') do
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
    validate_parameters(require_any_of: %i[instance_id name])

    if opts[:instance_id] && !opts[:instance_id].empty? # Use instance_id, if provided
      if !opts[:instance_id].is_a?(String) ||
           opts[:instance_id] !~ /(^i-[0-9a-f]{8})|(^i-[0-9a-f]{17})$/
        raise ArgumentError,
              "#{@__resource_name__}: `instance_id` must be a string in the format of 'i-' followed by 8 or 17 hexadecimal characters."
      end
      @display_name = opts[:instance_id]
      instance_arguments = { instance_ids: [opts[:instance_id]] }
    elsif opts[:name] && !opts[:name].empty? # Otherwise use name, if provided
      @display_name = opts[:name]
      instance_arguments = {
        filters: [{ name: "tag:Name", values: [opts[:name]] }]
      }
    else
      raise ArgumentError,
            "#{@__resource_name__}: either instance_id or name must be provided."
    end

    catch_aws_errors do
      resp = @aws.compute_client.describe_instances(instance_arguments)
      if resp.reservations.first.nil? ||
           resp.reservations.first.instances.first.nil?
        empty_response_warn
        return
      end
      if resp.reservations.count > 1 ||
           resp.reservations.first.instances.count > 1
        resource_fail
        return
      else
        @instance = resp.reservations.first.instances.first.to_h
      end

      create_resource_methods(@instance)

      # Methods required to ensure backwards compatibility
      class << self
        def state
          return unless @instance[:state]
          @instance[:state][:name]
        end

        def security_groups
          @instance[:security_groups].map do |sg|
            { id: sg[:group_id], name: sg[:group_name] }
          end
        end

        def tags
          return [] unless @instance[:tags]
          @instance[:tags].map { |tag| { key: tag[:key], value: tag[:value] } }
        end
      end
    end
  end

  def exists?
    !failed_resource?
  end

  def security_group_ids
    return unless @instance[:security_groups]
    @instance[:security_groups].map { |sg| sg[:group_id] }
  end

  def availability_zone
    return unless @instance[:placement]
    return unless @instance[:placement].include?(:availability_zone)
    @instance[:placement][:availability_zone]
  end

  def ebs_volumes
    return unless @instance[:block_device_mappings]
    return if @instance[:block_device_mappings].count == 0
    @instance[:block_device_mappings].map do |vol|
      { id: vol[:ebs][:volume_id], name: vol[:device_name] }
    end
  end

  def network_interface_ids
    return unless @instance[:network_interfaces]
    return if @instance[:network_interfaces].count == 0
    @instance[:network_interfaces].map { |nic| nic[:network_interface_id] }
  end

  def has_roles?
    unless @instance[:iam_instance_profile] &&
             @instance[:iam_instance_profile][:arn]
      return false
    end
    instance_profile = @instance[:iam_instance_profile][:arn].split("/").last
    @returned_roles = nil
    # Check if there is a role created at the attached profile
    catch_aws_errors do
      resp =
        @aws.iam_client.get_instance_profile(
          { instance_profile_name: instance_profile }
        )
      @returned_roles = resp.instance_profile.roles
    end
    @returned_roles && !@returned_roles.empty?
  end

  def role
    return unless has_roles?
    # You cannot attach multiple IAM roles to a single instance.
    # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html
    # An instance profile can contain only one role, and this limit cannot be increased.
    # https://docs.aws.amazon.com/cli/latest/reference/iam/add-role-to-instance-profile.html
    @returned_roles.first.role_name
  end

  # Generate a matcher for each state
  %w[
    pending
    running
    shutting-down
    terminated
    stopping
    stopped
    unknown
  ].each do |state_name|
    define_method "#{state_name.tr("-", "_")}?" do
      state == state_name
    end
  end

  def resource_id
    @instance ? @instance[:instance_id] : @display_name
  end

  def to_s
    "EC2 Instance #{@display_name}"
  end

  def tags_hash
    return nil unless exists?
    map_tags(tags)
  end
end
