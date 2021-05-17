# frozen_string_literal: true

require 'aws_backend'

class AWSEFSMountTargets < AwsResourceBase
  name 'aws_efs_mount_targets'
  desc 'Returns information about the endpoints for your account in the current region.'
  example `
    describe aws_efs_mount_targets do
      it { should exist }
    end
  `
  attr_reader :table

  FilterTable.create
             .register_column(:owner_ids,                               field: :owner_id)
             .register_column(:mount_target_ids,                        field: :mount_target_id)
             .register_column(:file_system_ids,                         field: :file_system_id)
             .register_column(:subnet_ids,                              field: :subnet_id)
             .register_column(:life_cycle_states,                       field: :life_cycle_state)
             .register_column(:ip_addresses,                            field: :ip_address)
             .register_column(:network_interface_ids,                   field: :network_interface_id)
             .register_column(:availability_zone_ids,                   field: :availability_zone_id)
             .register_column(:availability_zone_names,                 field: :availability_zone_name)
             .register_column(:vpc_ids,                                 field: :vpc_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(file_system_id))
    @query_params = {}
    @query_params[:file_system_id] = opts[:file_system_id]
    if opts.key?(:file_system_id)
      raise ArgumentError, "#{@__resource_name__}: file_system_id must be provided" unless opts[:file_system_id] && !opts[:file_system_id].empty?
      @query_params[:file_system_id] = opts[:file_system_id]
    end
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.efs_client.describe_mount_targets(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.mount_targets.map(&:to_h)
  end
end
