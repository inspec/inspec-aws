# frozen_string_literal: true

require 'aws_backend'

class AwsEbsSnapshot < AwsResourceBase
  name 'aws_ebs_snapshot'
  desc 'Verifies settings for an EBS snapshot'

  example "
    describe aws_ebs_snapshot('snap-12345678') do
      it  { should_not be_public }
      it  { should be_private }
      it  { should exist }
      its('encrypted') { should eq true }
    end

    describe aws_ebs_snapshot(name: 'my-volume') do
      its('encrypted') { should eq true }
    end
  "
  ALL = 'all'

  def initialize(opts = {})
    opts = { snapshot_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(snapshot_id name))
    catch_aws_errors do
      fetch_snapshot_propetries

      fetch_snapshot_permissions

      return if @snapshot.nil?

      @snapshot[:create_volume_permissions] = @snapshot_attributes_hash[:create_volume_permissions]

      # create_resource_methods(@snapshot_attributes_hash)
      create_resource_methods(@snapshot)

      # Methods required to ensure backwards compatibility
      class << self
        def tags
          @snapshot[:tags].map { |tag| { key: tag[:key], value: tag[:value] } }
        end
      end
    end
  end

  def exists?
    !@snapshot_obj.nil?
  end

  def public?
    (@group == ALL)
  end

  def private?
    @create_volume_permissions.empty?
  end

  def encrypted?
    @snapshot[:encrypted]
  end

  def to_s
    "EBS Snapshot #{@display_name}"
  end

  private

  # Getting snapshot specific general following properties:
  # API used: describe_snapshots
  def fetch_snapshot_propetries
    if opts[:snapshot_id] && !opts[:snapshot_id].empty?
      raise ArgumentError, "#{@__resource_name__}:  must be in the format 'snap- followed by 8 or 17 hexadecimal characters." if opts[:snapshot_id] !~ /^snap\-([0-9a-f]{8})|(^vol\-[0-9a-f]{17})$/
      @display_name = opts[:snapshot_id]
      snapshot_arguments = { snapshot_ids: [opts[:snapshot_id]] }
    elsif opts[:name] && !opts[:name].empty?
      @display_name = opts[:name]
      filter = { name: 'tag:Name', values: [opts[:name]] }
      snapshot_arguments = { filters: [filter] }
    else
      raise ArgumentError, "#{@__resource_name__}:  `snapshot_id` or `name` must be provided"
    end
    catch_aws_errors do
      snapshot_resp = @aws.compute_client.describe_snapshots(snapshot_arguments)
      return if snapshot_resp.snapshots.empty?
      @snapshot_obj = snapshot_resp.snapshots[0]
      @snapshot_id = @snapshot_obj.snapshot_id
      @snapshot = @snapshot_obj.to_h
    end
  end

  # Getting snapshot's attribute required for checking its accessiblility (using createVolumePermission) - public/private
  # API used: describe_snapshot_attribute
  def fetch_snapshot_permissions
    # return if !@snapshot_id
    if opts[:snapshot_id] && !opts[:snapshot_id].empty?
      raise ArgumentError, "#{@__resource_name__}:  must be in the format 'snap- followed by 8 or 17 hexadecimal characters." if opts[:snapshot_id] !~ /^snap\-([0-9a-f]{8})|(^snap\-[0-9a-f]{17})$/
      @display_name = opts[:snapshot_id]
      snapshot_attributes_arguments = {
        attribute: 'createVolumePermission',
        snapshot_id: opts[:snapshot_id],
      }
    elsif !@snapshot_id.nil?
      snapshot_attributes_arguments = {
        attribute: 'createVolumePermission',
        snapshot_id: @snapshot_id,
      }
    else
      return
    end
    catch_aws_errors do
      @resp_snapshot_attributes = @aws.compute_client.describe_snapshot_attribute(snapshot_attributes_arguments)
      @snapshot_attributes_hash = @resp_snapshot_attributes.to_h
      @create_volume_permissions = @resp_snapshot_attributes.create_volume_permissions
      if !@create_volume_permissions.empty?
        @group = @create_volume_permissions[0].group
      end
    end
  end
end
