require 'aws_backend'

class AWSRDSGlobalCluster < AwsResourceBase
  name 'aws_rds_global_cluster'
  desc 'Returns information about Aurora global database clusters.'

  example "
    describe aws_rds_global_cluster(global_cluster_identifier: 'GLOBAL_CLUSTER_IDENTIFIER') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(global_cluster_identifier))
    raise ArgumentError, "#{@__resource_name__}: global_cluster_identifier must be provided" unless opts[:global_cluster_identifier] && !opts[:global_cluster_identifier].empty?
    @display_name = opts[:global_cluster_identifier]
    catch_aws_errors do
      resp = @aws.rds_client.describe_global_clusters({ global_cluster_identifier: opts[:global_cluster_identifier] })
      @res = resp.global_clusters[0].to_h
      @global_cluster_resource_id = @res[:global_cluster_resource_id]
      create_resource_methods(@res)
    end
  end

  def resource_id
    @global_cluster_resource_id
  end

  def global_cluster_identifier
    return nil unless exists?
    @res[:global_cluster_identifier]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "RDS Global Cluster Identifier: #{@display_name}"
  end
end
