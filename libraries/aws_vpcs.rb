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
      vpc_rows+=[{ vpc_id: vpc[:vpc_id],
                   cidr_block: vpc[:cidr_block],
                   dhcp_options_id: vpc[:dhcp_options_id],
                   state: vpc[:state],
                   is_default: vpc[:is_default],
                   instance_tenancy: vpc[:instance_tenancy],
                   tags: map_tags(vpc[:tags]) }]
    end
    @table = vpc_rows
  end
end
