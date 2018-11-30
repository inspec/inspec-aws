# frozen_string_literal: true

require 'aws_backend'

class AwsSubnets < AwsResourceBase
  name 'aws_subnets'
  desc 'Verifies settings for an AWS VPC Subnets in bulk'

  example "
    describe aws_subnets.where(vpc_id: 'vpc-123456789') do
      its('subnet_ids') { should eq ['subnet-12345678', 'subnet-87654321'] }
      its('cidr_blocks') { should eq ['172.31.96.0/20'] }
      its('states') { should_not include 'pending' }
    end
  "

  def initialize(opts = {})
    # Call the parent class constructor
    super(opts)
    validate_parameters([])
  end

  # FilterTable setup
  filter_table_config = FilterTable.create
  filter_table_config.add(:cidr_blocks, field: :cidr_block)
  filter_table_config.add(:vpc_ids, field: :vpc_id)
  filter_table_config.add(:subnet_ids, field: :subnet_id)
  filter_table_config.add(:states, field: :state)
  filter_table_config.connect(self, :fetch_data)

  def fetch_data
    subnet_rows = []
    catch_aws_errors do
      @subnets = @aws.compute_client.describe_subnets.to_h[:subnets]
    end
    return [] if !@subnets || @subnets.empty?
    @subnets.each do |subnet|
      subnet_rows+=[{ subnet_id: subnet[:subnet_id],
                      vpc_id: subnet[:vpc_id],
                      cidr_block: subnet[:cidr_block],
                      state: subnet[:state] }]
    end
    @table = subnet_rows
  end
end
