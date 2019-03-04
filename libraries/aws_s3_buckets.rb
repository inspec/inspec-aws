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

  def initialize(opts = {})
    # Call the parent class constructor
    super(opts)
    validate_parameters([])
  end

  # FilterTable setup
  filter_table_config = FilterTable.create
  filter_table_config.add(:bucket_names, field: :bucket_name)
  filter_table_config.add(:tags, field: :tags)
  filter_table_config.connect(self, :fetch_data)

  def fetch_data
    bucket_rows = []
    catch_aws_errors do
      @api_response = @aws.storage_client.list_buckets
    end
    @api_response.each do |resp|
      resp.buckets.each do |bucket|
        bucket_rows += [{ bucket_name: bucket[:name],
                          tags: fetch_tags(bucket[:name]) }]
      end
    end
    @table = bucket_rows
  end

  def fetch_tags(bucket_name)
    tags = {}
    begin
      tag_list = @aws.storage_client.get_bucket_tagging(bucket: bucket_name)
      unless tag_list.nil? || tag_list.empty?
        tag_list.tag_set.each do |tag|
          tags[tag[:key].to_sym] = tag[:value]
        end
      end
    rescue
    end
    tags
  end
end
