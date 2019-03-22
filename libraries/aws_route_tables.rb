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
             .register_column(:route_table_ids, field: :route_table_id)
             .register_column(:vpc_ids,         field: :vpc_id)
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
      route_table_rows += [{ vpc_id: route_table[:vpc_id],
                             route_table_id: route_table[:route_table_id] }]
    end
    @table = route_table_rows
  end
end
