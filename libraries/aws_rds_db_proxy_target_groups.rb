# frozen_string_literal: true

require 'aws_backend'

class AWSRDSProxyTargetGroups < AwsResourceBase
  name 'aws_rds_db_proxy_target_groups'
  desc 'Returns information about DB proxy target groups'

  example "
    describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:db_proxy_names, field: :db_proxy_name)
             .register_column(:target_group_names, field: :target_group_name)
             .register_column(:target_group_arns, field: :target_group_arn)
             .register_column(:is_default, field: :is_default)
             .register_column(:statuses, field: :status)
             .register_column(:connection_pool_configs, field: :connection_pool_config)
             .register_column(:created_dates, field: :created_date)
             .register_column(:updated_dates, field: :updated_date)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(db_proxy_name))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: db_proxy_name must be provided" unless opts[:db_proxy_name] && !opts[:db_proxy_name].empty?
    @query_params[:db_proxy_name] = opts[:db_proxy_name]
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.rds_client.describe_db_proxy_target_groups(@query_params).map do |table|
        table.target_groups.map { |table_name| {
          db_proxy_name: table_name.db_proxy_name,
          target_group_name: table_name.target_group_name,
          target_group_arn: table_name.target_group_arn,
          is_default: table_name.is_default,
          status: table_name.status,
          connection_pool_config: table_name.connection_pool_config,
          created_date: table_name.created_date,
          updated_date: table_name.updated_date,
        }
        }
      end.flatten
    end
  end
end
