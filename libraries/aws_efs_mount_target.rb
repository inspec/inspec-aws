require 'aws_backend'

class AWSEFSMountTarget < AwsResourceBase
  name 'aws_efs_mount_target'
  desc 'Returns the descriptions of all the current mount targets, or a specific mount target, for a file system. When requesting all of the current mount targets, the order of mount targets returned in the response is unspecified.'
  example "
    describe aws_efs_mount_target(mount_target_id: 'test') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { mount_target_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:mount_target_id])
    raise ArgumentError, "#{@__resource_name__}: mount_target_id must be provided" unless opts[:mount_target_id] && !opts[:mount_target_id].empty?
    @display_name = opts[:mount_target_id]
    catch_aws_errors do
      resp = @aws.efs_client.describe_mount_targets({ mount_target_id: opts[:mount_target_id] })
      @mount_targets = resp.mount_targets[0].to_h
      create_resource_methods(@mount_targets)
    end
  end

  def mount_target_id
    return nil unless exists?
    @mount_targets[:mount_target_id]
  end

  def exists?
    !@mount_targets.nil? && !@mount_targets.empty?
  end

  def resource_id
    @display_name
  end

  def to_s
    "Mount Target ID: #{@display_name}"
  end
end
