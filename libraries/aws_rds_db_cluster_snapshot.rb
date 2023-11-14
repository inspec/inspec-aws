require "aws_backend"

class AWSRDSDBClusterSnapShot < AwsResourceBase
  name "aws_rds_db_cluster_snapshot"
  desc "Returns information about DB cluster snapshots."

  example "
    describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: 'DBSnapshotID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { db_cluster_snapshot_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i[db_cluster_snapshot_id])
    unless opts[:db_cluster_snapshot_id] &&
             !opts[:db_cluster_snapshot_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: db_cluster_snapshot_id must be provided"
    end
    @display_name = opts[:db_cluster_snapshot_id]
    filter = [
      {
        name: "db-cluster-snapshot-id",
        values: [opts[:db_cluster_snapshot_id]]
      }
    ]
    catch_aws_errors do
      resp = @aws.rds_client.describe_db_cluster_snapshots({ filters: filter })
      @res = resp.db_cluster_snapshots[0].to_h
      @db_cluster_snapshot_arn = @res[:db_cluster_snapshot_arn]
      create_resource_methods(@res)
    end
  end

  def db_cluster_snapshot_id
    return nil unless exists?
    @res[:db_cluster_snapshot_id]
  end

  def resource_id
    @db_cluster_snapshot_arn
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "RDS DB Snapshot ID: #{@display_name}"
  end
end
