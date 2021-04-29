# frozen_string_literal: true

require 'aws_backend'

class AwsVpcs < AwsResourceBase
  name 'aws_vpcs'
  desc 'Verifies settings for an AWS VPCs in bulk'

  example '
    describe aws_vpcs do
      it { should exist }
    end
  '
  attr_reader :table

  # FilterTable setup
  FilterTable.create
             .register_column(:cidr_blocks,        field: :cidr_block)
             .register_column(:vpc_ids,            field: :vpc_id)
             .register_column(:states,             field: :state)
             .register_column(:dhcp_options_ids,   field: :dhcp_options_id)
             .register_column(:instance_tenancys,  field: :instance_tenancy)
             .register_column(:is_defaults,        field: :is_default)
             .register_column(:tags,               field: :tags)
             .register_column(:ipv_6_cidr_block_association_sets,               field: :ipv_6_cidr_block_association_set)
             .register_column(:cidr_block_association_sets,                     field: :cidr_block_association_set)
             .register_column(:association_ids, field: :association_id)
             .register_column(:cidr_blocks, field: :cidr_block)
             .register_column(:cidr_block_states, field: :cidr_block_state)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  # def fetch_data
  #   vpc_rows = []
  #   catch_aws_errors do
  #     @vpcs = @aws.compute_client.describe_vpcs.to_h[:vpcs]
  #   end
  #   return [] if !@vpcs || @vpcs.empty?
  #   require 'pry'; binding.pry
  #   @vpcs.each do |vpc|
  #     vpc_rows+=[{ vpc_id: vpc[:vpc_id],
  #                  cidr_block: vpc[:cidr_block],
  #                  dhcp_options_id: vpc[:dhcp_options_id],
  #                  state: vpc[:state],
  #                  is_default: vpc[:is_default],
  #                  instance_tenancy: vpc[:instance_tenancy],
  #                  tags: map_tags(vpc[:tags]),
  #                  cidr_block_association_sets: vpc[:cidr_block_association_set],
  #                  ipv_6_cidr_block_association_sets: map_ipv_6_cidr_block_association_set(vpc[:ipv_6_cidr_block_association_sets])
  #     }]
  #   end
  #   @table = vpc_rows
  # end

  def fetch_data
    cidr_block_association_set_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_vpcs(pagination_options)
      end
      return [] if !@api_response || @api_response.empty?
      @api_response.vpcs.each do |res|
        res.cidr_block_association_set.each do |cidr_block_association|
          cidr_block_association_set_rows += [{
                              association_id: cidr_block_association.association_id,
                              cidr_block: cidr_block_association.cidr_block,
                              cidr_block_state: cidr_block_association.cidr_block_state
                            }]
          # require 'byebug'; byebug
        end
        # require 'pry'; binding.pry
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = cidr_block_association_set_rows
  end
end
