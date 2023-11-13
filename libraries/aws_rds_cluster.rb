require "aws_backend"

class AwsRdsCluster < AwsResourceBase
  name "aws_rds_cluster"
  desc "Verifies settings for an RDS Cluster."

  example "
    describe aws_rds_cluster(db_cluster_identifier: 'test-cluster-id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { db_cluster_identifier: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:db_cluster_identifier])

    raise ArgumentError, "#{@__resource_name__}: db_cluster_identifier must start with a letter followed by up to 62 letters/numbers/hyphens." if opts[:db_cluster_identifier] !~ /^[a-z]{1}[0-9a-z\-]{0,62}$/

    catch_aws_errors do
      @display_name = opts[:db_cluster_identifier]

      begin
        resp = @aws.rds_client.describe_db_clusters(db_cluster_identifier: opts[:db_cluster_identifier])
        return if resp.db_clusters.empty?
        @rds_cluster = resp.db_clusters[0].to_h
        @db_cluster_arn = @rds_cluster[:db_cluster_arn]
      rescue Aws::RDS::Errors::DBClusterNotFound
        return
      end
      unless @rds_cluster[:db_cluster_members].to_s.empty?
        cluster_members = @rds_cluster[:db_cluster_members]
        @rds_cluster[:db_cluster_members] = cluster_members.map { |x| x.values[0] }
      end
      create_resource_methods(@rds_cluster)
    end
  end

  def resource_id
    @db_cluster_arn
  end

  def has_encrypted_storage?
    @rds_cluster[:storage_encrypted]
  end
  # add this alias for consistency with ebs volumes
  alias encrypted? has_encrypted_storage?

  def tags
    begin
      tag_list = @aws.rds_client.list_tags_for_resource(resource_name: @rds_cluster[:db_cluster_arn]).tag_list
    rescue
      return {}
    end
    map_tags(tag_list)
  end

  def exists?
    !@rds_cluster.to_s.empty?
  end

  def to_s
    "RDS Cluster #{@display_name}"
  end
end
