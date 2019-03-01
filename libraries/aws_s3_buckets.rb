# frozen_string_literal: true

require 'aws_backend'

class AwsS3Buckets < AwsResourceBase
  name 'aws_s3_buckets'
  desc 'Verifies settings for AWS S3 Buckets in bulk'
  example "
    describe aws_s3_bucket do
      its('bucket_names') { should eq ['my_bucket'] }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:bucket_names, field: :bucket_name)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    # Call the parent class constructor
    super(opts)
    validate_parameters([])
    @table = fetch_data
  end

  def fetch_data
    bucket_rows = []
    catch_aws_errors do
      @api_response = @aws.storage_client.list_buckets.each do |resp|
        resp.buckets.each do |bucket|
          bucket_rows += [{ bucket_name: bucket[:name] }]
        end
      end
    end
    @table = bucket_rows
  end
end
