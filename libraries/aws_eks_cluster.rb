# frozen_string_literal: true

require 'aws_backend'

class AwsEksCluster < AwsResourceBase
  name 'aws_eks_cluster'
  desc 'Verifies settings for an EKS cluster'

  example "
    describe aws_eks_cluster('cluster-name') do
      it { should exist }
    end
  "

  attr_reader :version, :arn, :certificate_authority, :name,
              :status, :endpoint, :subnets_count, :subnet_ids, :security_group_ids,
              :created_at, :role_arn, :vpc_id, :security_groups_count, :creating,
              :active, :failed, :deleting, :tags, :enabled_logging_types, :disabled_logging_types

  def initialize(opts = {})
    opts = { cluster_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:cluster_name])

    catch_aws_errors do
      resp = @aws.eks_client.describe_cluster(name: opts[:cluster_name]).cluster

      @arn                   = resp[:arn]
      @version               = resp[:version]
      @certificate_authority = resp[:certificate_authority][:data]
      @name                  = resp[:name]
      @status                = resp[:status]
      @endpoint              = resp[:endpoint]
      @subnet_ids            = resp[:resources_vpc_config][:subnet_ids]
      @subnets_count         = resp[:resources_vpc_config][:subnet_ids].length
      @security_group_ids    = resp[:resources_vpc_config][:security_group_ids]
      @security_groups_count = resp[:resources_vpc_config][:security_group_ids].length
      @vpc_id                = resp[:resources_vpc_config][:vpc_id]
      @created_at            = resp[:created_at]
      @role_arn              = resp[:role_arn]
      @active                = resp[:status] == 'ACTIVE'
      @failed                = resp[:status] == 'FAILED'
      @creating              = resp[:status] == 'CREATING'
      @deleting              = resp[:status] == 'DELETING'
      @tags                  = resp[:tags]
      @enabled_logging_types = resp.dig(:logging, :cluster_logging)&.select(&:enabled)&.map { |type| type[:types] }
      @disabled_logging_types= resp.dig(:logging, :cluster_logging)&.reject(&:enabled)&.map { |type| type[:types] }
    end
  end

  def exists?
    @arn.start_with?('arn:')
  end

  def to_s
    "AWS EKS Cluster #{@name}"
  end
end
