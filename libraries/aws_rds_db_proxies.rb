# frozen_string_literal: true

require 'aws_backend'

class AWSRDSProxies < AwsResourceBase
  name 'aws_rds_db_proxies'
  desc 'Returns information about DB proxies.'

  example "
    describe aws_rds_db_proxies(db_proxy_name: 'DB_PROXY_NAME') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:db_proxy_names, field: :db_proxy_name)
             .register_column(:db_proxy_arns, field: :db_proxy_arn)
             .register_column(:statuses, field: :status)
             .register_column(:engine_families, field: :engine_family)
             .register_column(:vpc_ids, field: :vpc_id)
             .register_column(:vpc_security_group_ids, field: :vpc_security_group_ids)
             .register_column(:vpc_subnet_ids, field: :vpc_subnet_ids)
             .register_column(:auths, field: :auth)
             .register_column(:role_arns, field: :role_arn)
             .register_column(:endpoints, field: :endpoint)
             .register_column(:require_tls, field: :require_tls)
             .register_column(:idle_client_timeouts, field: :idle_client_timeout)
             .register_column(:debug_loggings, field: :debug_logging)
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
      @table = @aws.rds_client.describe_db_proxies(@query_params).map do |table|
        table.db_proxies.map { |table_name| {
          db_proxy_name: table_name.db_proxy_name,
          db_proxy_arn: table_name.db_proxy_arn,
          status: table_name.status,
          engine_family: table_name.engine_family,
          vpc_id: table_name.vpc_id,
          vpc_security_group_ids: table_name.vpc_security_group_ids,
          vpc_subnet_ids: table_name.vpc_subnet_ids,
          auth: table_name.auth,
          role_arn: table_name.role_arn,
          endpoint: table_name.endpoint,
          require_tls: table_name.require_tls,
          idle_client_timeout: table_name.idle_client_timeout,
          debug_logging: table_name.debug_logging,
          created_date: table_name.created_date,
          updated_date: table_name.updated_date,
        }
        }
      end.flatten
    end
  end
end
