require "aws_backend"

class AWSRDSProxyEndpoints < AwsResourceBase
  name "aws_rds_db_proxy_endpoints"
  desc "Returns information about DB proxy endpoints."

  example "
    describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:db_proxy_endpoint_names, field: :db_proxy_endpoint_name)
    .register_column(:db_proxy_endpoint_arns, field: :db_proxy_endpoint_arn)
    .register_column(:db_proxy_names, field: :db_proxy_name)
    .register_column(:statuses, field: :status)
    .register_column(:vpc_ids, field: :vpc_id)
    .register_column(:vpc_security_group_ids, field: :vpc_security_group_ids)
    .register_column(:vpc_subnet_ids, field: :vpc_subnet_ids)
    .register_column(:endpoints, field: :endpoint)
    .register_column(:created_dates, field: :created_date)
    .register_column(:target_roles, field: :target_role)
    .register_column(:is_default, field: :is_default)
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
      @table = @aws.rds_client.describe_db_proxy_endpoints(@query_params).map do |table|
        table.db_proxy_endpoints.map { |table_name| {
          db_proxy_endpoint_name: table_name.db_proxy_endpoint_name,
          db_proxy_endpoint_arn: table_name.db_proxy_endpoint_arn,
          db_proxy_name: table_name.db_proxy_name,
          status: table_name.status,
          vpc_id: table_name.vpc_id,
          vpc_security_group_ids: table_name.vpc_security_group_ids,
          vpc_subnet_ids: table_name.vpc_subnet_ids,
          endpoint: table_name.endpoint,
          created_date: table_name.created_date,
          target_role: table_name.target_role,
          is_default: table_name.is_default,
        }
        }
      end.flatten
    end
  end
end
