require "aws_backend"

class AwsEksClusters < AwsCollectionResourceBase
  name "aws_eks_clusters"
  desc "Verifies settings for a collection AWS EKS Clusters."
  example "
    describe aws_eks_clusters do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data

    # custom keys
    table_schema = [
      { column: :created_at, field: :created_at },
      { column: :creating, field: :creating },
      { column: :active, field: :active },
      { column: :failed, field: :failed },
      { column: :deleting, field: :deleting },
    ]

    AwsCollectionResourceBase.populate_filter_table(:table, table_schema)

    populate_filter_table_from_response
  end

  def fetch_data
    fetch(client: :eks_client, operation: :list_clusters).flat_map do |response|
      response.clusters.flat_map do |cluster_name|
        cluster_attributes_from(cluster_name)
      end
    end
  end

  private

  def cluster_attributes_from(cluster_name)
    cluster = fetch(client: :eks_client, operation: :describe_cluster, kwargs: { name: cluster_name }).cluster
    cluster.to_h.merge({
                         version:               cluster.version,
      arn:                   cluster.arn,
      certificate_authority: cluster.certificate_authority.data,
      name:                  cluster.name,
      status:                cluster.status,
      endpoint:              cluster.endpoint,
      security_group_ids:    cluster.resources_vpc_config.security_group_ids,
      subnets_count:         cluster.resources_vpc_config.subnet_ids.length,
      subnet_ids:            cluster.resources_vpc_config.subnet_ids,
      created_at:            cluster.created_at,
      role_arn:              cluster.role_arn,
      vpc_id:                cluster.resources_vpc_config.vpc_id,
      security_groups_count: cluster.resources_vpc_config.security_group_ids.length,
      creating:              cluster.status == "CREATING",
      active:                cluster.status == "ACTIVE",
      failed:                cluster.status == "FAILED",
      deleting:              cluster.status == "DELETING",
                       })
  end
end
