# frozen_string_literal: true

require 'aws_backend'

class AwsEmrClusters < AwsResourceBase
  name 'aws_emr_clusters'
  desc 'Verifies settings for a collection of AWS EMR Clusters.'
  example "
    describe aws_emr_clusters do
      it { should exist }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:cluster_ids, field: :cluster_id)
             .register_column(:cluster_names, field: :cluster_name)
             .register_column(:cluster_arns, field: :cluster_arn)
             .register_column(:state, field: :state)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    cluster_rows = []
    resp = {}
    pagination_options = {}

    catch_aws_errors do
      resp = @aws.emr_client.list_clusters(pagination_options)
    end

    return [] if !resp || resp.empty?

    resp.clusters.each do |c|
      cluster_rows += [{  cluster_arn:  c.cluster_arn,
        cluster_id:   c.id,
        cluster_name: c.name,
        state:        c.status.state }]
    end
    @table = cluster_rows
  end
end
