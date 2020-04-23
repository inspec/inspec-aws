# frozen_string_literal: true

require 'aws_backend'

class AwsElastiCacheClusters < AwsResourceBase
  name 'aws_elasti_cache_clusters'
  desc 'Verifies settings for a collection of AWS Elasticache Clusters'
  example "
    describe aws_elasticache_clusters do
      its('count') { should eq 3 }
    end

    # Iterate through all clusters
    aws_elasti_cache_clusters.cache_cluster_ids.each do |cache_cluster_id|
      describe aws_elasti_cache_cluster(cache_cluster_id) do
        it { should be_encrypted_at_rest }
        its('engine') { should cmp 'redis' }
      end
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:cache_cluster_ids, field: :cache_cluster_id)
             .register_column(:cache_node_types, field: :cache_node_type)
             .register_column(:engines, field: :engine)
             .register_column(:cache_cluster_statuses, field: :cache_cluster_status)
             .register_column(:preferred_availability_zones, field: :preferred_availability_zone)
             .register_column(:cache_subnet_group_names, field: :cache_subnet_group_name)
             .register_column(:encryption_status_at_rest, field: :at_rest_encryption_enabled)
             .register_column(:encryption_status_at_transit, field: :transit_encryption_enabled)
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
          cache_cluster_id: cache_cluster.cache_cluster_id,
          cache_node_type: cache_cluster.cache_node_type,
          engine: cache_cluster.engine,
          cache_cluster_status: cache_cluster.cache_cluster_status,
          preferred_availability_zone: cache_cluster.preferred_availability_zone,
          cache_subnet_group_name: cache_cluster.cache_subnet_group_name,
          at_rest_encryption_enabled: cache_cluster.at_rest_encryption_enabled,
          transit_encryption_enabled: cache_cluster.transit_encryption_enabled,
        }]
      end
      break unless @api_response.marker
      pagination_options = { marker: @api_response[:marker] }
    end
    elasticache_cluster_rows
  end
end
