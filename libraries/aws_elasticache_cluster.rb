require 'aws_backend'

class AwsElastiCacheCluster < AwsResourceBase
  name 'aws_elasticache_cluster'
  desc 'Verifies settings for an AWS Elasticache Cluster.'

  example "
    describe aws_elasticache_cluster('my-cluster-001') do
      it { should be_encrypted_at_transit }
    end

    describe aws_elasticache_cluster(cache_cluster_id: 'my-cluster-001') do
      it { should exist }
      its('engine') { should cmp 'redis' }
    end
  "

  def initialize(opts = {})
    # cache_cluster_id value can be provided as a string.
    # Convert it to a hash type object with the 'cache_cluster_id' key.
    opts = { cache_cluster_id: opts } if opts.is_a?(String)
    #  Ignore arguments if they are not hash type at this point.
    opts = {} unless opts.is_a?(Hash)

    # Cluster identifier can only be the 'cache_cluster_id'.
    raise ArgumentError, "#{@__resource_name__}:  `cache_cluster_id` must be provided." unless opts.key?(:cache_cluster_id)
    # cache_cluster_id constraints: https://docs.aws.amazon.com/cli/latest/reference/elasticache/create-cache-cluster.html
    unless /^(?!\d)(?!.*\-$)(?!.*?\-\-)[a-zA-Z0-9\-]{1,50}$/.match?(opts[:cache_cluster_id])
      raise ArgumentError, "#{@__resource_name__}: cache_cluster_id must contain between 1 and 50 alphanumeric characters or hyphens, should start with a letter, and cannot end with a hyphen or contain two consecutive hyphens."
    end
    query_arguments = { cache_cluster_id: opts[:cache_cluster_id] }

    super(opts)
    # cache_cluster_id is the only query argument here.
    validate_parameters(required: [query_arguments.keys.first])
    @display_name = query_arguments.values.first

    # Ensure the response will have the detailed information about the cache nodes associated with the cluster.
    query_arguments[:show_cache_node_info] = true

    catch_aws_errors do
      begin
        resp = @aws.elasti_cache_client.describe_cache_clusters(query_arguments)
        @cache_cluster = resp.cache_clusters.first.to_h
      rescue Aws::ElastiCache::Errors::CacheClusterNotFoundFault
        return
      end
      create_resource_methods(@cache_cluster)
    end
  end

  def id
    @cache_cluster[:cache_cluster_id] || nil
  end

  def resource_id
    @cache_cluster? @cache_cluster[:cache_cluster_id] : @display_name
  end

  def node_ids
    @cache_cluster[:cache_nodes].map { |node| node[:cache_node_id] }
  end

  def ports
    return unless status == 'available'
    # This will return a hash with `node_id : port` pairs.
    @cache_cluster[:cache_nodes].map { |node| [node[:cache_node_id], node[:endpoint][:port]] }.to_h
  end

  def status
    @cache_cluster[:cache_cluster_status]
  end

  def exists?
    !@cache_cluster.nil? && !@cache_cluster.empty?
  end

  def encrypted_at_rest?
    @cache_cluster[:at_rest_encryption_enabled]
  end

  def encrypted_at_transit?
    @cache_cluster[:transit_encryption_enabled]
  end

  def to_s
    "ElastiCache Cluster #{@display_name}"
  end

  # ElastiCache clusters can have cost tags: https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Tagging.html
  # Tags can be queried with `list-tags-for-resource`, which requires ARN of the resource:
  # arn:aws:elasticache:<region>:<customer-id>:<resource-type>:<resource-name>
  # The `<customer-id>` can be queried with `organizations list-accounts`.
  # However, this requires a privileged AWS account.
  # We don't include `tags` method here assuming that users with programmatic access should not run with high privileges.
end
