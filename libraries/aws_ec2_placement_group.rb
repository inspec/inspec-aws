# frozen_string_literal: true

require 'aws_backend'

class AWSEC2PlacementGroup < AwsResourceBase
  name 'aws_ec2_placement_group'
  desc 'Audits Placement Group'

  example "
    describe aws_ec2_placement_group(group_id: 'test-group-id') do
      it { should exist }
    end

    describe aws_ec2_placement_group(group_name: 'test-group-name') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { group_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(group_name group_id))

    if opts[:group_id] && !opts[:group_id].empty? # Use instance_id, if provided
      if !opts[:group_id].is_a?(String) || opts[:group_id] !~ /(^pg-[0-9a-f]{8})|(^i-[0-9a-f]{17})$/
        raise ArgumentError, "#{@__resource_name__}: `group_id` must be a string in the format of 'pg-' followed by 8 or 17 hexadecimal characters."
      end
      @display_group_id = opts[:group_id]
      placement_group_arguments = { group_ids: [opts[:group_id]] }
    elsif opts[:group_name] && !opts[:group_name].empty? # Otherwise use name, if provided
      @display_group_name = opts[:group_name]
      placement_group_arguments = { group_names: [opts[:group_name]] }
    else
      raise ArgumentError, "#{@__resource_name__}: either group_name or group_id must be provided."
    end

    catch_aws_errors do
      resp = @aws.compute_client.describe_placement_groups(placement_group_arguments)
      @placement_groups = resp.placement_groups[0].to_h
      create_resource_methods(@placement_groups)
    end
  end

  def exists?
    !@placement_groups.nil? && !@placement_groups.empty?
  end

  def to_s
    "Placement Groups ID: #{@display_group_id}"
  end
end
