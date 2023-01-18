require "aws_backend"

class AwsSubnets < AwsResourceBase
  name "aws_subnets"
  desc "Verifies settings for an AWS VPC Subnets in bulk."

  example "
    describe aws_subnets do
      it { should exist }
    end

    describe aws_subnets.where(vpc_id: 'vpc-123456789') do
      its('subnet_ids') { should eq ['subnet-12345678', 'subnet-87654321'] }
      its('cidr_blocks') { should eq ['172.31.96.0/20'] }
      its('states') { should_not include 'pending' }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:availability_zone,       field: :availability_zone)
    .register_column(:cidr_blocks,             field: :cidr_block)
    .register_column(:map_public_ip_on_launch, field: :map_public_ip_on_launch)
    .register_column(:states,                  field: :state)
    .register_column(:subnet_ids,              field: :subnet_id)
    .register_column(:vpc_ids,                 field: :vpc_id)
    .register_column(:tags,                    field: :tags)
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
    return subnet_rows if !@subnets || @subnets.empty?
    @subnets.each do |subnet|
      subnet_rows += [{
        availability_zone:       subnet[:availability_zone],
        cidr_block:              subnet[:cidr_block],
        map_public_ip_on_launch: subnet[:map_public_ip_on_launch],
        state:                   subnet[:state],
        subnet_id:               subnet[:subnet_id],
        vpc_id:                  subnet[:vpc_id],
        tags:                    subnet[:tags],
      }]
    end
    @table = subnet_rows
  end
end
