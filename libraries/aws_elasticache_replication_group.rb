require "aws_backend"

class AwsElastiCacheReplicationGroup < AwsResourceBase
  name "aws_elasticache_replication_group"
  desc "Verifies settings for an AWS Elasticache Replication Group"

  example "
    describe aws_elasticache_replication_group('my-replication_group-001') do
      it { should be_encrypted_at_transit }
    end

    describe aws_elasticache_replication_group(replication_group_id: 'my-replication_group-001') do
      it { should exist }
      its('engine') { should cmp 'redis' }
    end
  "

  def initialize(opts = {})
    # replication_group_id value can be provided as a string.
    # Convert it to a hash type object with the 'replication_group_id' key.
    opts = { replication_group_id: opts } if opts.is_a?(String)
    #  Ignore arguments if they are not hash type at this point.
    opts = {} unless opts.is_a?(Hash)

    # Replication Group identifier can only be the 'replication_group_id'.
    raise ArgumentError, "#{@__resource_name__}:  `replication_group_id` must be provided." unless opts.key?(:replication_group_id)
    # replication_group_id constraints: https://docs.aws.amazon.com/cli/latest/reference/elasticache/create-replication-group.html
    unless /^(?!\d)(?!.*\-$)(?!.*?\-\-)[a-zA-Z0-9\-]{1,50}$/.match?(opts[:replication_group_id])
      raise ArgumentError, "#{@__resource_name__}: replication_group_id must contain between 1 and 50 alphanumeric characters or hyphens, should start with a letter, and cannot end with a hyphen or contain two consecutive hyphens."
    end
    query_arguments = { replication_group_id: opts[:replication_group_id] }

    super(opts)
    # replication_group_id is the only query argument here.
    validate_parameters(required: query_arguments.keys)
    @display_name = query_arguments[:replication_group_id]

    catch_aws_errors do
      resp = @aws.elasti_cache_client.describe_replication_groups(query_arguments)
      @replication_group = resp.replication_groups.first.to_h
    end
    create_resource_methods(@replication_group)
  end

  def id
    @replication_group[:replication_group_id]
  end

  def resource_id
    @replication_group? @replication_group[:replication_group_id] : @display_name
  end

  def status
    @replication_group[:status]
  end

  def exists?
    !@replication_group.nil? && !@replication_group.empty?
  end

  def encrypted_at_rest?
    @replication_group[:at_rest_encryption_enabled]
  end

  def encrypted_at_transit?
    @replication_group[:transit_encryption_enabled]
  end

  def auto_failover?
    @replication_group[:automatic_failover]
  end

  def to_s
    "ElastiCache Replication Group #{@display_name}"
  end
end
