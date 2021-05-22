# frozen_string_literal: true

require 'aws_backend'

class AWSTransferUsers < AwsResourceBase
  name 'aws_transfer_users'
  desc ''
  example `
    describe aws_transfer_users do
      it { should exist }
    end
  `

  attr_reader :table

  FilterTable.create
             .register_column(:arns,                                    field: :arn)
             .register_column(:home_directories,                        field: :home_directory)
             .register_column(:home_directory_types,                    field: :home_directory_type)
             .register_column(:roles,                                   field: :role)
             .register_column(:ssh_public_key_counts,                   field: :ssh_public_key_count)
             .register_column(:user_names,                              field: :user_name)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(server_id))
    @query_params = {}
    @query_params[:server_id] = opts[:server_id]
    if opts.key?(:server_id)
      raise ArgumentError, "#{@__resource_name__}: server_id must be provided" unless opts[:server_id] && !opts[:server_id].empty?
      @query_params[:server_id] = opts[:server_id]
    end
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.transfer_client.list_users(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.users.map(&:to_h)
  end
end
