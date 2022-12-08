require "aws_backend"

class AWSCloudFrontCachePolicies < AwsResourceBase
  name "aws_cloudfront_cache_policies"
  desc "Gets a list of cache policies."

  example "
    describe aws_cloudfront_cache_policies do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:types, field: :type)
    .register_column(:ids, field: :id)
    .register_column(:last_modified_times, field: :last_modified_time)
    .register_column(:comments, field: :comment)
    .register_column(:names, field: :name)
    .register_column(:default_ttls, field: :default_ttl)
    .register_column(:max_ttls, field: :max_ttl)
    .register_column(:min_ttls, field: :min_ttl)
    .register_column(:enable_accept_encoding_gzips, field: :enable_accept_encoding_gzip)
    .register_column(:enable_accept_encoding_brotlis, field: :enable_accept_encoding_brotli)
    .register_column(:header_behaviors, field: :header_behavior)
    .register_column(:cookie_behaviors, field: :cookie_behavior)
    .register_column(:query_string_behaviors, field: :query_string_behavior)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.cloudfront_client.list_cache_policies.map do |table|
        table.cache_policy_list.items.map { |table_name| {
          type: table_name.type,
          id: table_name.cache_policy.id,
          last_modified_time: table_name.cache_policy.last_modified_time,
          comment: table_name.cache_policy.cache_policy_config.comment,
          name: table_name.cache_policy.cache_policy_config.name,
          default_ttl: table_name.cache_policy.cache_policy_config.default_ttl,
          max_ttl: table_name.cache_policy.cache_policy_config.max_ttl,
          min_ttl: table_name.cache_policy.cache_policy_config.min_ttl,
        }
        }
      end.flatten
    end
  end
end
