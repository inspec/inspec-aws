require "aws_backend"

class AwsRedshiftClusters < AwsResourceBase
  name "aws_redshift_clusters"
  desc "Verifies settings for a collection AWS RDS Clusters."
  example "
    describe aws_redshift_clusters do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:cluster_identifiers, field: :cluster_identifier)
    .register_column(:node_types, field: :node_type)
    .register_column(:cluster_status, field: :cluster_status)
    .register_column(:cluster_availability_status, field: :cluster_availability_status)
    .register_column(:db_names, field: :db_name)
    .register_column(:modify_status, field: :modify_status)
    .register_column(:master_usernames, field: :master_username)
    .register_column(:cluster_create_time, field: :cluster_create_time)
    .register_column(:cluster_subnet_group_names, field: :cluster_subnet_group_name)
    .register_column(:availability_zones, field: :availability_zones)
    .register_column(:allow_version_upgrade, field: :allow_version_upgrade)
    .register_column(:encrypted, field: :encrypted)
    .register_column(:iam_roles, field: :iam_roles)
    .register_column(:vpc_ids, field: :vpc_id)
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
      response = @aws.redshift_client.describe_clusters(pagination_options)
      return cluster_rows if !response || response.empty?
      response.clusters.each do |redshift_cluster|
        cluster_rows += [{ cluster_identifier:               redshift_cluster.cluster_identifier,
                           node_type:                        redshift_cluster.node_type,
                           cluster_status:                   redshift_cluster.cluster_status,
                           cluster_availability_status:      redshift_cluster.cluster_availability_status,
                           master_username:                  redshift_cluster.master_username,
                           db_name:                          redshift_cluster.db_name,
                           cluster_create_time:              redshift_cluster.cluster_create_time,
                           cluster_subnet_group_name:        redshift_cluster.cluster_subnet_group_name,
                           vpc_id:                           redshift_cluster.vpc_id,
                           allow_version_upgrade:            redshift_cluster.allow_version_upgrade,
                           encrypted:                        redshift_cluster.encrypted,
                           iam_roles:                        redshift_cluster.iam_roles,
                           modify_status:                    redshift_cluster.modify_status,
                           availability_zone:                redshift_cluster.availability_zone }]
      end
    end
    @table = cluster_rows
  end
end
