# frozen_string_literal: true

require 'aws_backend'

class AwsElasticacheCluster < AwsResourceBase
  name 'aws_elasticache_cluster'
  desc 'Verifies settings for an AWS Elasticache Cluster'

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
    if opts.key?(:cache_cluster_id)
      # cache_cluster_id constraints: https://docs.aws.amazon.com/cli/latest/reference/elasticache/create-cache-cluster.html
      unless /^(?!\d)(?!.*\-$)(?!.*?\-\-)[a-zA-Z0-9\-]{1,50}$/.match?(opts[:cache_cluster_id])
        raise ArgumentError, "#{@__resource_name__}: cache_cluster_id must contain between 1 and 50 alphanumeric characters or hyphens, should start with a letter, and cannot end with a hyphen or contain two consecutive hyphens."
      end
      query_arguments = { cache_cluster_id: opts[:cache_cluster_id] }
    else
      raise ArgumentError, "#{@__resource_name__}:  `cache_cluster_id` must be provided."
    end

    super(opts)
    # cache_cluster_id is the only query argument here.
    validate_parameters(required: [query_arguments.keys.first])
    @display_name = query_arguments.values.first

    # Ensure the response will have the detailed information about the cache nodes associated with the cluster.
    query_arguments[:show_cache_node_info] = true

    catch_aws_errors do
      begin
        resp = @aws.elasticache_client.describe_cache_clusters(query_arguments)
        @cache_cluster = resp.cache_clusters.first.to_h
        # Empty response should be considered as resource not found.
        if @cache_cluster.empty?
          raise Aws::ElastiCache::Errors::CacheClusterNotFoundFault.new(resp, "#{@__resource_name__} not found.")
        end
      rescue Aws::ElastiCache::Errors::CacheClusterNotFoundFault
        return
      end
      create_resource_methods(@cache_cluster)
    end
  end

  def id
    @cache_cluster[:cache_cluster_id] || nil
  end

  def node_ids
    # puts @cache_cluster
    @cache_cluster[:cache_nodes].map { |node| node[:cache_node_id] }
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
    "Elasticache Cluster #{@display_name}"
  end
end
