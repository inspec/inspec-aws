require 'aws_backend'

class AwsEksCluster < AwsResourceBase
  name 'aws_eks_cluster'
  desc 'Verifies settings for an EKS cluster.'

  example "
    describe aws_eks_cluster('cluster-name') do
      it { should exist }
    end
  "

  attr_reader :certificate_authority,
              :subnets_count, :subnet_ids, :security_group_ids,
              :vpc_id, :security_groups_count, :creating,
              :active, :failed, :deleting, :enabled_logging_types, :disabled_logging_types

  def initialize(opts = {})
    opts = { cluster_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:cluster_name]) unless @resource_data

    @resp = @resource_data || get_resource(opts)
    create_resource_methods(@resp)

    @certificate_authority = @resp[:certificate_authority].is_a?(Hash) ? @resp.dig(:certificate_authority, :data) : @resp[:certificate_authority]
    @subnet_ids            = @resp[:resources_vpc_config][:subnet_ids]
    @subnets_count         = @resp[:resources_vpc_config][:subnet_ids].length
    @security_group_ids    = @resp[:resources_vpc_config][:security_group_ids]
    @security_groups_count = @resp[:resources_vpc_config][:security_group_ids].length
    @vpc_id                = @resp[:resources_vpc_config][:vpc_id]
    @active                = @resp[:status] == 'ACTIVE'
    @failed                = @resp[:status] == 'FAILED'
    @creating              = @resp[:status] == 'CREATING'
    @deleting              = @resp[:status] == 'DELETING'

    @enabled_logging_types = @resp.dig(:logging, :cluster_logging)&.select { |log| log[:enabled] }&.map { |type| type[:types] }&.flatten
    @disabled_logging_types= @resp.dig(:logging, :cluster_logging)&.reject { |log| log[:enabled] }&.map { |type| type[:types] }&.flatten
  end

  def resource_id
    return @name unless exists?
    @resp[:arn]
  end

  def exists?
    arn.start_with?('arn:')
  end

  def to_s
    "AWS EKS Cluster #{@name}"
  end

  private

  def get_resource(opts)
    catch_aws_errors do
      @aws.eks_client.describe_cluster(name: opts[:cluster_name]).cluster.to_h
    end
  end
end
