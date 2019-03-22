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

  attr_reader :table

  FilterTable.create
             .register_column(:cidr_blocks, field: :cidr_block)
             .register_column(:vpc_ids,     field: :vpc_id)
             .register_column(:subnet_ids,  field: :subnet_id)
             .register_column(:states,      field: :state)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

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
