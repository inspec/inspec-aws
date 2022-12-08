require "aws_backend"

class AwsCloudTrailTrails < AwsResourceBase
  name "aws_cloudtrail_trails"
  desc "Verifies settings for AWS CloudTrail Trails in bulk."
  example "
    describe aws_cloudtrail_trails do
      it { should exist }
    end
  "

  attr_reader :table

  def initialize(opts = {})
    # Call the parent class constructor
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  FilterTable.create
    .register_column(:trail_arns, field: :trail_arn)
    .register_column(:names,      field: :name)
    .install_filter_methods_on_resource(self, :table)

  def fetch_data
    cloudtrail_rows = []
    catch_aws_errors do
      @cloudtrails = @aws.cloudtrail_client.describe_trails({}).to_h[:trail_list]
    end
    return cloudtrail_rows if !@cloudtrails || @cloudtrails.empty?
    @cloudtrails.each do |cloudtrail|
      cloudtrail_rows+=[{ trail_arn: cloudtrail[:trail_arn],
                          name: cloudtrail[:name] }]
    end
    @table = cloudtrail_rows
  end
end
