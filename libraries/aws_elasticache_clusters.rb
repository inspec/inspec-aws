require 'aws_backend'

class AwsElastiCacheClusters < AwsResourceBase
  name 'aws_elasticache_clusters'
  desc 'Verifies settings for a collection of AWS Elasticache Clusters.'
  example "
    describe aws_elasticache_clusters do
      its('count') { should eq 3 }
    end

    # Iterate through all clusters
    aws_elasticache_clusters.cache_cluster_ids.each do |cache_cluster_id|
      describe aws_elasticache_cluster(cache_cluster_id) do
        it { should be_encrypted_at_rest }
        its('engine') { should cmp 'redis' }
      end
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids, field: :id)
             .register_column(:node_types, field: :node_type)
             .register_column(:engines, field: :engine)
             .register_column(:status, field: :status)
             .register_column(:zones, field: :zone)
             .register_column(:subnet_group_names, field: :subnet_group_name)
             .register_column(:encrypted_at_rest, field: :encrypted_at_rest)
             .register_column(:encrypted_at_transit, field: :encrypted_at_transit)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    elasticache_cluster_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.elasti_cache_client.describe_cache_clusters(**pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.cache_clusters.each do |cache_cluster|
        elasticache_cluster_rows += [{
          id: cache_cluster.cache_cluster_id,
          node_type: cache_cluster.cache_node_type,
          engine: cache_cluster.engine,
          status: cache_cluster.cache_cluster_status,
          zone: cache_cluster.preferred_availability_zone,
          subnet_group_name: cache_cluster.cache_subnet_group_name,
          encrypted_at_rest: cache_cluster.at_rest_encryption_enabled,
          encrypted_at_transit: cache_cluster.transit_encryption_enabled,
        }]
      end
      break unless @api_response.marker
      pagination_options = { marker: @api_response[:marker] }
    end
    elasticache_cluster_rows
  end
end
