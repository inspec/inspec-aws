# frozen_string_literal: true

require 'aws_backend'

class AwsRegions < AwsResourceBase
  name 'aws_regions'
  desc 'Verifies settings for AWS Regions in bulk'

  example '
    describe aws_regions do
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
  filter_table_config.add(:region_names, field: :region_name)
  filter_table_config.add(:endpoints, field: :endpoint)
  filter_table_config.connect(self, :fetch_data)

  def fetch_data
    region_rows = []
    catch_aws_errors do
      @regions = @aws.compute_client.describe_regions.to_h[:regions]
    end
    return [] if !@regions || @regions.empty?
    @regions.each do |region|
      region_rows += [{ region_name: region[:region_name],
                        endpoint: region[:endpoint] }]
    end
    @table = region_rows
  end
end
