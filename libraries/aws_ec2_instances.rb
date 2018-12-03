# frozen_string_literal: true

require 'aws_backend'

class AwsEc2Instances < AwsResourceBase
  name 'aws_ec2_instances'
  desc 'Verifies settings for AWS EC2 Instances in bulk'
  example '
    describe aws_ec2_instances do
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
  filter_table_config.add(:instance_ids, field: :instance_id)
  filter_table_config.add(:vpc_ids, field: :vpc_id)
  filter_table_config.add(:subnet_ids, field: :subnet_id)
  filter_table_config.add(:instance_types, field: :instance_type)
  filter_table_config.connect(self, :fetch_data)

  def fetch_data
    instance_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_instances(pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.reservations.each do |res|
        instance_rows += res.instances.map do |instance|
          {
              instance_id: instance.instance_id,
              vpc_id: instance.vpc_id,
              subnet_id: instance.subnet_id,
              instance_type: instance.instance_type,
          }
        end
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = instance_rows
  end
end
