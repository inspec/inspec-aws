require "aws_backend"

class AWSTransferUsers < AwsResourceBase
  name "aws_transfer_users"
  desc "Lists the users for a file transfer protocol-enabled server that you specify by passing the ServerId parameter."

  example "
    describe aws_transfer_users(server_id: 's-0123456789') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:arns,                                    field: :arn)
    .register_column(:home_directories,                        field: :home_directory)
    .register_column(:home_directory_types,                    field: :home_directory_type)
    .register_column(:roles,                                   field: :role)
    .register_column(:ssh_public_key_count, field: :ssh_public_key_count)
    .register_column(:user_names, field: :user_name)
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
    rows = []
    @query_params[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.transfer_client.list_users(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.users.each do |resp|
        rows += [{ arn: resp.arn,
                   home_directory: resp.home_directory,
                   home_directory_type: resp.home_directory_type,
                   role: resp.role,
                   ssh_public_key_count: resp.ssh_public_key_count,
                   user_name: resp.user_name }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
