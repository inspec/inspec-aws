# frozen_string_literal: true

require 'aws_backend'

class AWSSOAssignments < AwsResourceBase
  name 'aws_sso_assignments'
  desc 'Lists the assignee of the specified Amazon Web Services account with the specified permission set.'

  example "
    describe aws_sso_assignments(instance_arn: 'INSTANCE_ARN', account_id: 'ACCOUNT_ID', permission_set_arn: 'PERMISSION_SET_ARN') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:account_ids, field: :account_id)
             .register_column(:permission_set_arns, field: :permission_set_arn)
             .register_column(:principal_types, field: :principal_type)
             .register_column(:principal_ids, field: :principal_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(instance_arn account_id permission_set_arn))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: instance_arn must be provided" unless opts[:instance_arn] && !opts[:instance_arn].empty?
    raise ArgumentError, "#{@__resource_name__}: service_namespace must be provided" unless opts[:service_namespace] && !opts[:service_namespace].empty?
    raise ArgumentError, "#{@__resource_name__}: service_namespace must be provided" unless opts[:service_namespace] && !opts[:service_namespace].empty?
    @query_params[:instance_arn] = opts[:instance_arn]
    @query_params[:account_id] = opts[:account_id]
    @query_params[:permission_set_arn] = opts[:permission_set_arn]
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.sso_client.account_assignments(@query_params).map do |table|
        table.account_assignments.map { |table_name| {
          account_id: table_name.account_id,
          permission_set_arn: table_name.permission_set_arn,
          principal_type: table_name.principal_type,
          principal_id: table_name.principal_id,
        }
        }
      end.flatten
    end
  end
end
