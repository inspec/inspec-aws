require "aws_backend"

class AWSEFSMountTargets < AwsResourceBase
  name "aws_efs_mount_targets"
  desc "Returns the descriptions of all the current mount targets, or a specific mount target, for a file system. When requesting all of the current mount targets, the order of mount targets returned in the response is unspecified."

  example "
    describe aws_efs_mount_targets(file_system_id: 'fs-01234567') do
      it { should exist }
    end
  "

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
    table_rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.efs_client.describe_mount_targets(@query_params)
      end
      return table_rows if !@api_response || @api_response.empty?
      @api_response.mount_targets.each do |res|
        table_rows+=[{ owner_id: res.owner_id,
                       mount_target_id: res.mount_target_id,
                       file_system_id: res.file_system_id,
                       subnet_id: res.subnet_id,
                       life_cycle_state: res.life_cycle_state,
                       ip_address: res.ip_address,
                       network_interface_id: res.network_interface_id,
                       availability_zone_id: res.availability_zone_id,
                       availability_zone_name: res.availability_zone_name,
                       vpc_id: res.vpc_id }]
      end
      break unless @api_response.next_marker
      @query_params[:next_marker] = @api_response.next_marker
    end
    table_rows
  end
end
