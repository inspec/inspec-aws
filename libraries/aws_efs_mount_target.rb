# frozen_string_literal: true

require 'aws_backend'

class AWSEFSMountTarget < AwsResourceBase
  name 'aws_efs_mount_target'
  desc 'Returns information about the endpoints for your account in the current region.'

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
    @display_name = opts[:endpoint_identifier]
    catch_aws_errors do
      resp = @aws.efs_client.describe_mount_targets({ mount_target_id: opts[:mount_target_id] })
      @mount_targets = resp.mount_targets[0].to_h
      create_resource_methods(@mount_targets)
    end
  end

  def id
    return nil unless exists?
    @mount_targets[:mount_target_id]
  end

  def exists?
    !@mount_targets.nil? && !@mount_targets.empty?
  end

  def encrypted?
    @mount_targets[:encrypted]
  end

  def to_s
    "Mount Target ID: #{@display_name}"
  end
end
