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

  def initialize(opts = {})
    super(opts)
    validate_parameters([])
  end

  # FilterTable setup
  filter_table_config = FilterTable.create
  filter_table_config.add(:route_table_ids, field: :route_table_id)
  filter_table_config.add(:vpc_ids, field: :vpc_id)
  filter_table_config.connect(self, :fetch_data)

  def fetch_data
    route_table_rows = []
    catch_aws_errors do
      @route_tables = @aws.compute_client.describe_route_tables({}).to_h[:route_tables]
    end
    return [] if !@route_tables || @route_tables.empty?
    @route_tables.each do |route_table|
      route_table_rows += [{ vpc_id: route_table[:vpc_id],
                             route_table_id: route_table[:route_table_id] }]
    end
    @table = route_table_rows
  end
end
