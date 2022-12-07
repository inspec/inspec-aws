require 'aws_backend'

class AwsS3Buckets < AwsResourceBase
  name 'aws_s3_buckets'
  desc 'Verifies settings for AWS S3 Buckets in bulk.'
  example "
    describe aws_s3_bucket do
      its('bucket_names') { should eq ['my_bucket'] }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:bucket_names, field: :bucket_name)
             .register_column(:tags, field: :tags, lazy: ->(r, c, t) { r[:tags] = fetch_tags_from(r, c, t) })
             .install_filter_methods_on_resource(self, :table)

  # helps to lazy load tags
  def self.fetch_tags_from(row, _condition, table)
    instance = table.resource_instance
    tag_list = instance.catch_aws_errors do
      instance.aws.storage_client.get_bucket_tagging(bucket: row[:bucket_name])
    end
    instance.map_tags(tag_list&.tag_set)
  end

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    bucket_rows = []
    catch_aws_errors do
      @api_response = @aws.storage_client.list_buckets
    end
    @api_response.each do |resp|
      resp.buckets.each do |bucket|
        bucket_rows += [{ bucket_name: bucket[:name] }]
      end
    end
    @table = bucket_rows
  end
end
