require 'aws_backend'

class AwsElastiCacheClusterNode < AwsResourceBase
  name 'aws_elasticache_cluster_node'
  desc 'Verifies settings for an AWS Elasticache Cluster Node.'

  example "
    describe aws_elasticache_cluster_node(cache_cluster_id: 'my-elasticache-cluster', node_id: '0001') do
      it { should exist }
      its{'port' } { should cmp 11211 }
      its('status') { should eq 'available' }
    end
  "

  def initialize(opts = {})
    super(opts)
    # cache_cluster_id and node_id have to be provided.
    validate_parameters(required: %i(cache_cluster_id node_id))

    # cache_cluster_id constraints: https://docs.aws.amazon.com/cli/latest/reference/elasticache/create-cache-cluster.html
    unless /^(?!\d)(?!.*\-$)(?!.*?\-\-)[a-zA-Z0-9\-]{1,50}$/.match?(opts[:cache_cluster_id])
      raise ArgumentError, "#{@__resource_name__}: cache_cluster_id must contain between 1 and 50 alphanumeric characters or hyphens, should start with a letter, and cannot end with a hyphen or contain two consecutive hyphens."
    end
    # node_id constraints: https://docs.aws.amazon.com/cli/latest/reference/elasticache/describe-cache-clusters.html
    error_message = 'node_id must be a string containing 4 digits.'
    raise ArgumentError, "#{@__resource_name__}: #{error_message}" unless opts[:node_id].is_a?(String)
    unless /^[\d]{4}$/.match?(opts[:node_id])
      raise ArgumentError, "#{@__resource_name__}: #{error_message}"
    end
    @display_name = "Node #{opts[:node_id]} of ElastiCache Cluster #{opts[:cache_cluster_id]}"

    # Ensure the response will have the detailed information about the cache node.
    query_arguments = { cache_cluster_id: opts[:cache_cluster_id] }
    query_arguments[:show_cache_node_info] = true

    catch_aws_errors do
      begin
        resp = @aws.elasti_cache_client.describe_cache_clusters(query_arguments)
        @cache_cluster = resp.cache_clusters.first.to_h
      rescue Aws::ElastiCache::Errors::CacheClusterNotFoundFault
        return
      end
    end
    # If AWS API can not find a cluster we should return.
    return if @cache_cluster.nil?
    @cluster_node = @cache_cluster[:cache_nodes].select { |node| opts[:node_id] == node[:cache_node_id] }.first
    raise Inspec::Exceptions::ResourceFailed, "#{@__resource_name__} #{opts[:node_id]} not found for  #{query_arguments[:cache_cluster_id]}." if @cluster_node.nil?
  end

  def id
    @cluster_node[:cache_node_id] unless @cluster_node.nil?
  end

  def status
    @cluster_node[:cache_node_status] unless @cluster_node.nil?
  end

  def address
    @cluster_node[:endpoint][:address] unless @cluster_node.nil?
  end

  def parameter_group_status
    @cluster_node[:parameter_group_status] unless @cluster_node.nil?
  end

  def customer_availability_zone
    @cluster_node[:customer_availability_zone] unless @cluster_node.nil?
  end

  def create_time
    @cluster_node[:cache_node_create_time] unless @cluster_node.nil?
  end

  def source_cache_node_id
    @cluster_node[:source_cache_node_id] unless @cluster_node.nil?
  end

  def port
    @cluster_node[:endpoint][:port] unless @cluster_node.nil?
  end

  def resource_id
    @cluster_node? @cluster_node[:cache_node_id]:@display_name
  end

  def exists?
    !id.nil?
  end

  def to_s
    @display_name
  end
end
