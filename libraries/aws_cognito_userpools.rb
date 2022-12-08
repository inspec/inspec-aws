require "aws_backend"

class AWSCognitoUserPools < AwsResourceBase
  name "aws_cognito_userpools"
  desc "Lists the user pools associated with an AWS account."

  example "
    describe aws_cognito_userpools do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:ids,                                 field: :id)
    .register_column(:names,                               field: :name)
    .register_column(:lambda_configs,                      field: :lambda_config)
    .register_column(:statuses,                            field: :status)
    .register_column(:last_modified_dates,                 field: :last_modified_date)
    .register_column(:creation_dates,                      field: :creation_date)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @query_params = {}
    @query_params[:max_results] = opts[:max_results]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:max_results] = 60
    loop do
      catch_aws_errors do
        @api_response = @aws.cognitoidentityprovider_client.list_user_pools(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.user_pools.each do |res|
        rows += [{
          id: res.id,
          name: res.name,
          lambda_config: res.lambda_config,
          status: res.status,
          last_modified_date: res.last_modified_date,
          creation_date: res.creation_date,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
