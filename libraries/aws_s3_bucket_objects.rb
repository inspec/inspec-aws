require "aws_backend"

class AwsS3BucketObjects < AwsResourceBase
  name "aws_s3_bucket_objects"
  desc "List all the objects for a particular bucket."

  example "
    describe aws_s3_bucket_objects(bucket_name: 'test_bucket_name') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:contents, field: :contents)
    .register_column(:contents_keys, field: :contents_keys, style: :simple)
    .register_column(:contents_last_modified, field: :contents_last_modified, style: :simple)
    .register_column(:contents_etags, field: :contents_etags, style: :simple)
    .register_column(:contents_sizes, field: :contents_sizes, style: :simple)
    .register_column(:contents_storage_classes, field: :contents_storage_classes, style: :simple)
    .register_column(:contents_owners, field: :contents_owners, style: :simple)
    .register_column(:names, field: :name)
    .register_column(:prefixes, field: :prefix)
    .register_column(:delimiters, field: :delimiter)
    .register_column(:max_keys, field: :max_keys)
    .register_column(:common_prefixes, field: :common_prefixes, style: :simple)
    .register_column(:encoding_types, field: :encoding_type)
    .register_column(:key_counts, field: :key_count)
    .register_column(:continuation_tokens, field: :continuation_token)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(bucket_name))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: bucket_name must be provided" unless opts[:bucket_name] && !opts[:bucket_name].empty?
    @query_params[:bucket] = opts[:bucket_name]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.storage_client.list_objects_v2(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.each do |resp|
        rows += [{ contents: resp.contents,
                   contents_keys: resp.contents.map(&:key),
                   contents_last_modified: resp.contents.map(&:last_modified),
                   contents_etags: resp.contents.map(&:etag),
                   contents_sizes: resp.contents.map(&:size),
                   contents_storage_classes: resp.contents.map(&:storage_class),
                   contents_owners: resp.contents.map(&:owner),
                   name: resp.name,
                   prefix: resp.prefix,
                   delimiter: resp.delimiter,
                   max_keys: resp.max_keys,
                   common_prefixes: resp.common_prefixes.map(&:prefix),
                   encoding_type: resp.encoding_type,
                   key_count: resp.key_count,
                   continuation_token: resp.continuation_token }]
      end
      break unless @api_response.next_continuation_token
      @query_params[:start_after] = @api_response.start_after
    end
    rows
  end
end
