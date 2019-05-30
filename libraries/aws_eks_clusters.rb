# frozen_string_literal: true

require 'aws_backend'

class AwsEksClusters < AwsResourceBase
  name 'aws_eks_clusters'
  desc 'Verifies settings for a collection AWS EKS Clusters'
  example '
    describe aws_eks_queues do
      it { should exist }
    end
  '

  attr_reader :table

  FilterTable.create
             .register_column(:arns,                    field: :arn)
             .register_column(:names,                   field: :name)
             .register_column(:endpoints,               field: :endpoint)
             .register_column(:statuses,                field: :status)
             .register_column(:versions,                field: :version)
             .register_column(:certificate_authorities, field: :certificate_authority)
             .register_column(:subnets_counts,          field: :subnets_count)
             .register_column(:subnet_ids,              field: :subnet_ids)
             .register_column(:security_groups_counts,  field: :security_groups_count)
             .register_column(:security_group_ids,      field: :security_group_ids)
             .register_column(:role_arns,               field: :role_arn)
             .register_column(:vpc_ids,                 field: :vpc_id)
             .register_column(:created_at,              field: :created_at)
             .register_column(:creating,                field: :creating)
             .register_column(:active,                  field: :active)
             .register_column(:failed,                  field: :failed)
             .register_column(:deleting,                field: :deleting)
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
