# frozen_string_literal: true

require 'aws_backend'

class AwsVpcs < AwsResourceBase
  name 'aws_vpcs'
  desc 'Verifies settings for an AWS VPCs in bulk.'

  example '
    describe aws_vpcs do
      it { should exist }
    end
  '
  attr_reader :table

  # FilterTable setup
  FilterTable.create
             .register_column(:cidr_blocks,                                     field: :cidr_block)
             .register_column(:vpc_ids,                                         field: :vpc_id)
             .register_column(:states,                                          field: :state)
             .register_column(:dhcp_options_ids,                                field: :dhcp_options_id)
             .register_column(:instance_tenancys,                               field: :instance_tenancy)
             .register_column(:is_defaults,                                     field: :is_default)
             .register_column(:tags,                                            field: :tags)
             .register_column(:cidr_association_ids,                            field: :cidr_association_ids, style: :simple)
             .register_column(:cidr_states,                                     field: :cidr_states, style: :simple)
             .register_column(:cidr_status_messages,                            field: :cidr_status_messages, style: :simple)
             .register_column(:ipv_6_cidr_association_ids,                      field: :ipv_6_cidr_association_ids, style: :simple)
             .register_column(:ipv_6_cidr_states,                               field: :ipv_6_cidr_states, style: :simple)
             .register_column(:ipv_6_cidr_status_messages,                      field: :ipv_6_cidr_status_messages, style: :simple)
             .register_column(:ipv_6_cidr_network_border_groups,                field: :ipv_6_cidr_network_border_groups, style: :simple)
             .register_column(:ipv_6_cidr_ipv_6_pools,                          field: :ipv_6_cidr_ipv_6_pools, style: :simple)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    vpc_rows = []
    catch_aws_errors do
      @vpcs = @aws.compute_client.describe_vpcs.to_h[:vpcs]
    end
    return [] if !@vpcs || @vpcs.empty?
    @vpcs.each do |vpc|
      vpc_rows+=[{
        vpc_id: vpc[:vpc_id],
        cidr_block: vpc[:cidr_block],
        dhcp_options_id: vpc[:dhcp_options_id],
        state: vpc[:state],
        is_default: vpc[:is_default],
        instance_tenancy: vpc[:instance_tenancy],
        tags: map_tags(vpc[:tags]),

        cidr_association_ids: vpc[:cidr_block_association_set].map { |association_set| association_set[:association_id] },
        cidr_states: vpc[:cidr_block_association_set].map { |association_set| association_set.dig(:cidr_block_state, :state) },
        cidr_status_messages: vpc[:cidr_block_association_set].map { |association_set| association_set.dig(:cidr_block_state, :status_message) },

        ipv_6_cidr_association_ids: vpc[:ipv_6_cidr_block_association_set]&.map { |association_set| association_set[:association_id] },
        ipv_6_cidr_states: vpc[:ipv_6_cidr_block_association_set]&.map { |association_set| association_set.dig(:ipv_6_cidr_block_state, :state) },
        ipv_6_cidr_status_messages: vpc[:ipv_6_cidr_block_association_set]&.map { |association_set| association_set.dig(:ipv_6_cidr_block_state, :status_message) },
        ipv_6_cidr_network_border_groups: vpc[:ipv_6_cidr_block_association_set]&.map { |association_set| association_set[:network_border_group] },
        ipv_6_cidr_ipv_6_pools: vpc[:ipv_6_cidr_block_association_set]&.map { |association_set| association_set[:ipv_6_pool] },
      }]
    end
    @table = vpc_rows
  end
end
