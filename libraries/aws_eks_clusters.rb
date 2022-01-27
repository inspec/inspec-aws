# frozen_string_literal: true

require 'aws_backend'

class AwsEksClusters < AwsCollectionResourceBase
  name 'aws_eks_clusters'
  desc 'Verifies settings for a collection AWS EKS Clusters.'
  example "
    describe aws_eks_clusters do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    cluster_rows = []
    pagination_options = {}
    catch_aws_errors do
      response = @aws.eks_client.list_clusters(pagination_options)
      return [] if !response || response.empty?
      response.clusters.each do |cluster_name|
        cluster = @aws.eks_client.describe_cluster(name: cluster_name).cluster
        cluster_rows += [{ version:               cluster.version,
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
                           creating:              cluster.status == 'CREATING',
                           active:                cluster.status == 'ACTIVE',
                           failed:                cluster.status == 'FAILED',
                           deleting:              cluster.status == 'DELETING' }]
      end
    end
    @table = cluster_rows
  end
end
