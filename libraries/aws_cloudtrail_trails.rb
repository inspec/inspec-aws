# frozen_string_literal: true

require 'aws_backend'

class AwsCloudTrailTrails < AwsResourceBase
  name 'aws_cloudtrail_trails'
  desc 'Verifies settings for AWS CloudTrail Trails in bulk'
  example '
    describe aws_cloudtrail_trails do
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
  filter_table_config.add(:trail_arns, field: :trail_arn)
  filter_table_config.add(:names, field: :name)
  filter_table_config.connect(self, :fetch_data)

  def fetch_data
    cloudtrail_rows = []
    catch_aws_errors do
      @cloudtrails = @aws.cloudtrail_client.describe_trails({}).to_h[:trail_list]
    end
    return [] if !@cloudtrails || @cloudtrails.empty?
    @cloudtrails.each do |cloudtrail|
      cloudtrail_rows+=[{ trail_arn: cloudtrail[:trail_arn],
                          name: cloudtrail[:name] }]
    end
    @table = cloudtrail_rows
  end
end
