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

  def initialize(opts = {})
    # Call the parent class constructor
    super(opts)
    validate_parameters([])
  end

  # FilterTable setup
  filter_table_config = FilterTable.create
  filter_table_config.add(:cidr_blocks, field: :cidr_block)
  filter_table_config.add(:vpc_ids, field: :vpc_id)
  filter_table_config.add(:states, field: :state)
  filter_table_config.add(:dhcp_options_ids, field: :dhcp_options_id)
  filter_table_config.add(:instance_tenancys, field: :instance_tenancy)
  filter_table_config.add(:is_defaults, field: :is_default)
  filter_table_config.add(:tags, field: :tags)
  filter_table_config.connect(self, :fetch_data)

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
