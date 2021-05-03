# frozen_string_literal: true

require 'aws_backend'

class AwsDbParameterGroups < AwsResourceBase
  name 'aws_db_parameter_groups'
  desc 'Verifies settings for a Parameter Group in bulk'
  example '
    describe aws_db_parameter_groups do
      it { should exist }
    end
  '

  attr_reader :table, :api_response

  FilterTable.create
             .register_column(:db_parameter_group_names,                field: :db_parameter_group_name)
             .register_column(:db_parameter_group_families,             field: :db_parameter_group_family)
             .register_column(:descriptions,                            field: :description)
             .register_column(:db_parameter_group_arns,                 field: :db_parameter_group_arn)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    parameter_group_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.rds_client.describe_db_parameter_groups(pagination_options)
      end
      return [] if !api_response || api_response.empty?

      api_response.db_parameter_groups.each do |parameter_group|
        parameter_group_rows += [{ db_parameter_group_name:        parameter_group.db_parameter_group_name,
                                db_parameter_group_family:         parameter_group.db_parameter_group_family,
                                description:                       parameter_group.description,
                                db_parameter_group_arn:            parameter_group.db_parameter_group_arn }]
      end
      break unless api_response.marker
      pagination_options = { marker: api_response[:marker] }
    end
    @table = parameter_group_rows
  end
end
