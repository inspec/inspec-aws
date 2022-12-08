require "aws_backend"

class AwsRdsClusters < AwsResourceBase
  name "aws_rds_clusters"
  desc "Verifies settings for a collection AWS RDS Clusters."
  example "
    describe aws_rds_clusters do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:cluster_identifier,       field: :cluster_identifier)
    .register_column(:database_name,            field: :database_name)
    .register_column(:cluster_members,          field: :cluster_members)
    .register_column(:engine,                   field: :engine)
    .register_column(:engine_version,           field: :engine_version)
    .register_column(:status,                   field: :status)
    .register_column(:allocated_storage,        field: :allocated_storage)
    .register_column(:storage_encrypted,        field: :storage_encrypted)
    .register_column(:availability_zones,       field: :availability_zones)
    .register_column(:multi_az,                 field: :multi_az)
    .register_column(:arn,                      field: :arn)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    cluster_rows = []
    pagination_options = {}
    catch_aws_errors do
      response = @aws.rds_client.describe_db_clusters(pagination_options)
      return [] if !response || response.empty?
      response.db_clusters.each do |rds_cluster|
        cluster_rows += [{ cluster_identifier:               rds_cluster.db_cluster_identifier,
                           database_name:                    rds_cluster.database_name,
                           cluster_members:                  rds_cluster.db_cluster_members.map(&:db_instance_identifier),
                           engine:                           rds_cluster.engine,
                           engine_version:                   rds_cluster.engine_version,
                           status:                           rds_cluster.status,
                           allocated_storage:                rds_cluster.allocated_storage,
                           storage_encrypted:                rds_cluster.storage_encrypted,
                           availability_zones:               rds_cluster.availability_zones,
                           multi_az:                         rds_cluster.multi_az,
                           arn:                              rds_cluster.db_cluster_arn }]
      end
    end
    @table = cluster_rows
  end
end
