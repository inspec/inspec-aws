require "aws_backend"

class AWSRDSGlobalClusters < AwsResourceBase
  name "aws_rds_global_clusters"
  desc "Returns information about DB Global Cluster."

  example "
    describe aws_rds_global_clusters do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:global_cluster_identifiers, field: :global_cluster_identifier)
    .register_column(:global_cluster_resource_ids, field: :global_cluster_resource_id)
    .register_column(:global_cluster_arns, field: :global_cluster_arn)
    .register_column(:statuses, field: :status)
    .register_column(:engines, field: :engine)
    .register_column(:vpc_security_group_ids, field: :vpc_security_group_ids)
    .register_column(:engine_versions, field: :engine_version)
    .register_column(:database_names, field: :database_name)
    .register_column(:storage_encrypted, field: :role_arn)
    .register_column(:deletion_protection, field: :deletion_protection)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.rds_client.describe_global_clusters.map do |table|
        table.global_clusters.map { |table_name| {
          global_cluster_identifier: table_name.global_cluster_identifier,
          global_cluster_resource_id: table_name.global_cluster_resource_id,
          global_cluster_arn: table_name.global_cluster_arn,
          status: table_name.status,
          engine: table_name.engine,
          engine_version: table_name.engine_version,
          database_name: table_name.database_name,
          storage_encrypted: table_name.storage_encrypted,
          deletion_protection: table_name.deletion_protection,
        }
        }
      end.flatten
    end
  end
end
