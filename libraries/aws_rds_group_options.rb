# frozen_string_literal: true

require 'aws_backend'

class AwsRdsGroupOptions < AwsResourceBase
  name 'aws_rds_group_options'
  desc 'Verifies settings for a collection AWS RDS Clusters'
  example '
    describe aws_rds_group_options do
      it { should exist }
    end
  '

  attr_reader :table

  FilterTable.create
             .register_column(:option_group_name, field: :option_group_name)
             .register_column(:option_group_description, field: :option_group_description)
             .register_column(:engine_name, field: :engine_name)
             .register_column(:major_engine_version, field: :major_engine_version)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    option_group_rows = []
    pagination_options = {}
    catch_aws_errors do
      response = @aws.rds_client.describe_option_groups(pagination_options)
      return [] if !response || response.empty?
      response.option_groups_list.each do |rds_option_group|
        option_group_rows += [{ cluster_identifier:          rds_option_group.option_group_name,
                           database_name:                    rds_option_group.option_group_description,
                           engine_name:                      rds_option_group.engine_name,
                           major_engine_version:             rds_option_group.major_engine_version }]
      end
    end
    @table = option_group_rows
  end
end
