require 'aws_backend'

class AwsElastiCacheReplicationGroups < AwsResourceBase
  name 'aws_elasticache_replication_groups'
  desc 'Verifies settings for a collection of AWS Replication Groups'
  example "
    describe aws_elasticache_replication_groups do
      its('count') { should eq 3 }
    end

    # Iterate through all clusters
    aws_elasticache_replication_groups.ids.each do |replication_group_id|
      describe aws_elasticache_replication_group(replication_group_id) do
        it { should be_encrypted_at_rest }
        its('engine') { should cmp 'redis' }
      end
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids, field: :id)
             .register_column(:node_types, field: :node_type)
             .register_column(:status, field: :status)
             .register_column(:encrypted_at_rest, field: :encrypted_at_rest)
             .register_column(:encrypted_at_transit, field: :encrypted_at_transit)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    elasticache_replication_group_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.elasti_cache_client.describe_replication_groups(**pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.replication_groups.each do |replication_group|
        elasticache_replication_group_rows += [{ id: replication_group.replication_group_id,
                                               node_type: replication_group.cache_node_type,
                                               status: replication_group.status,
                                               encrypted_at_rest: replication_group.at_rest_encryption_enabled,
                                               encrypted_at_transit: replication_group.transit_encryption_enabled }]
      end
      break unless @api_response.marker
      pagination_options = { marker: @api_response[:marker] }
    end
    elasticache_replication_group_rows
  end
end
