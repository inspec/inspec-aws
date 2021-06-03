# frozen_string_literal: true

require 'aws_backend'

class AwsRouteTables < AwsResourceBase
  name 'aws_route_tables'
  desc 'Verifies settings for an AWS Route Tables in bulk'

  example '
    describe aws_route_tables do
      it { should exist }
    end
  '

  attr_reader :table

  FilterTable.create
             .register_column(:route_table_ids,                           field: :route_table_id)
             .register_column(:vpc_ids,                                   field: :vpc_id)
             .register_column(:destination_cidr_blocks,                   field: :destination_cidr_block, style: :simple)
             .register_column(:destination_ipv_6_cidr_blocks,             field: :destination_ipv_6_cidr_block, style: :simple)
             .register_column(:destination_prefix_list_ids,               field: :destination_prefix_list_id, style: :simple)
             .register_column(:egress_only_internet_gateway_ids,          field: :egress_only_internet_gateway_id, style: :simple)
             .register_column(:gateway_ids,                               field: :gateway_id, style: :simple)
             .register_column(:instance_ids,                              field: :instance_id, style: :simple)
             .register_column(:instance_owner_ids,                        field: :instance_owner_id, style: :simple)
             .register_column(:nat_gateway_ids,                           field: :nat_gateway_id, style: :simple)
             .register_column(:transit_gateway_ids,                       field: :transit_gateway_id, style: :simple)
             .register_column(:local_gateway_ids,                         field: :local_gateway_id, style: :simple)
             .register_column(:carrier_gateway_ids,                       field: :carrier_gateway_id, style: :simple)
             .register_column(:network_interface_ids,                     field: :network_interface_id, style: :simple)
             .register_column(:origins,                                   field: :origin, style: :simple)
             .register_column(:states,                                    field: :state, style: :simple)
             .register_column(:vpc_peering_connection_ids,                field: :vpc_peering_connection_id, style: :simple)
             .register_column(:route_table_association_ids,               field: :route_table_association_ids, style: :simple)
             .register_column(:association_subnet_ids,                    field: :association_subnet_ids, style: :simple)
             .register_column(:associated_subnet_ids,                     field: :associated_subnet_ids, style: :simple)
             .register_column(:association_gateway_ids,                   field: :association_gateway_ids, style: :simple)
             .register_column(:associated_gateway_ids,                    field: :associated_gateway_ids, style: :simple)
             .register_column(:association_states,                        field: :association_states, style: :simple)
             .register_column(:main,                                      field: :main, style: :simple)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    route_table_rows = []
    catch_aws_errors do
      @route_tables = @aws.compute_client.describe_route_tables({}).to_h[:route_tables]
    end
    return [] if !@route_tables || @route_tables.empty?
    @route_tables.each do |route_table|
      route_table_rows += [{
        vpc_id: route_table[:vpc_id],
        route_table_id: route_table[:route_table_id],
        destination_cidr_block: route_table[:routes].collect { |hash_obj| hash_obj[:destination_cidr_block] }.flatten,
        destination_ipv_6_cidr_block: route_table[:routes].collect { |hash_obj| hash_obj[:destination_ipv_6_cidr_block] }.flatten,
        destination_prefix_list_id: route_table[:routes].collect { |hash_obj| hash_obj[:destination_prefix_list_id] }.flatten,
        egress_only_internet_gateway_id: route_table[:routes].collect { |hash_obj| hash_obj[:egress_only_internet_gateway_id] }.flatten,
        gateway_id: route_table[:routes].collect { |hash_obj| hash_obj[:gateway_id] }.flatten,
        instance_id: route_table[:routes].collect { |hash_obj| hash_obj[:instance_id] }.flatten,
        instance_owner_id: route_table[:routes].collect { |hash_obj| hash_obj[:instance_owner_id] }.flatten,
        nat_gateway_id: route_table[:routes].collect { |hash_obj| hash_obj[:nat_gateway_id] }.flatten,
        transit_gateway_id: route_table[:routes].collect { |hash_obj| hash_obj[:transit_gateway_id] }.flatten,
        local_gateway_id: route_table[:routes].collect { |hash_obj| hash_obj[:local_gateway_id] }.flatten,
        carrier_gateway_id: route_table[:routes].collect { |hash_obj| hash_obj[:carrier_gateway_id] }.flatten,
        network_interface_id: route_table[:routes].collect { |hash_obj| hash_obj[:network_interface_id] }.flatten,
        origin: route_table[:routes].collect { |hash_obj| hash_obj[:origin] }.flatten,
        state: route_table[:routes].collect { |hash_obj| hash_obj[:state] }.flatten,
        vpc_peering_connection_id: route_table[:routes].collect { |hash_obj| hash_obj[:vpc_peering_connection_id] }.flatten,
      }]
    end
    @table = route_table_rows
  end
end
