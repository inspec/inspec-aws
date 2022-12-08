require "aws_backend"

class AWSCognitoUserPoolClients < AwsResourceBase
  name "aws_cognito_userpool_clients"
  desc "Lists the clients that have been created for the specified user pool."

  example "
    describe aws_cognito_userpool_clients(user_pool_id: 'test1') do
      its('count') { should eq 3 }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:client_ids,                      field: :client_id)
    .register_column(:user_pool_ids,                   field: :user_pool_id)
    .register_column(:client_names,                    field: :client_name)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(user_pool_id))
    @query_params = {}
    @query_params[:user_pool_id] = opts[:user_pool_id]
    if opts.key?(:user_pool_id)
      raise ArgumentError, "#{@__resource_name__}: user_pool_id must be provided" unless opts[:user_pool_id] && !opts[:user_pool_id].empty?
      @query_params[:user_pool_id] = opts[:user_pool_id]
    end
    @table = fetch_data
  end

  def fetch_data
    table_rows = []
    @query_params[:max_results] = 100

    loop do
      catch_aws_errors do
        @api_response = @aws.cognitoidentityprovider_client.list_user_pool_clients(@query_params)
      end
      return table_rows if !@api_response || @api_response.empty?
      @api_response.user_pool_clients.each do |res|
        table_rows += [{
          client_id: res.client_id,
          user_pool_id: res.user_pool_id,
          client_name: res.client_name,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    table_rows
  end
end
