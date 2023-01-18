require "aws_backend"

class AwsRedshiftCluster < AwsResourceBase
  name "aws_redshift_cluster"
  desc "Verifies an Redshift Cluster."

  example "
    describe aws_redshift_cluster(cluster_identifier: 'test-cluster-id') do
      it { should exist }
    end
  "
  def initialize(opts = {})
    opts = { cluster_identifier: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:cluster_identifier])
    @display_name = opts[:cluster_identifier]
    raise ArgumentError, "#{@__resource_name__}: cluster_identifier must start with a letter followed by up to 62 letters/numbers/hyphens." if opts[:cluster_identifier] !~ /^[a-z]{1}[0-9a-z\-]{0,62}$/
    catch_aws_errors do
      resp = @aws.redshift_client.describe_clusters(cluster_identifier: opts[:cluster_identifier])
      return if resp.clusters.empty?
      @rds_cluster = resp.clusters[0].to_h
      create_resource_methods(@rds_cluster)
    end
  end

  def be_encrypted?
    @rds_cluster[:encrypted]
  end

  def resource_id
    @display_name
  end

  alias encrypted? be_encrypted?

  def exists?
    !@rds_cluster.nil? && !@rds_cluster.empty?
  end

  def to_s
    "Redshift Cluster Identifier: #{@display_name}"
  end
end
