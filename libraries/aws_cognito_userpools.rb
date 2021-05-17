# frozen_string_literal: true

require 'aws_backend'

class AWSCognitoUserPools < AwsResourceBase
  name 'aws_cognito_userpools'
  desc 'Gets details about a particular identity pool, including the pool name, ID description, creation date, and current number of users.'
  example `
    describe aws_cognito_userpools do
      it { should exist }
    end
  `

  attr_reader :table

  FilterTable.create
             .register_column(:ids,                         field: :id)
             .register_column(:names,                       field: :name)
             .register_column(:statuses,                    field: :status)
             .register_column(:last_modified_dates,         field: :last_modified_date)
             .register_column(:creation_dates,              field: :creation_date)
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
        @api_response = @aws.cognitoidentity_client.list_identity_pools(@query_params)
      end
      return [] if !@api_response || @api_response.empty?
      @api_response.identity_pools.each do |identity_pool|
        rows += [{
          identity_pool_id: identity_pool.identity_pool_id,
          identity_pool_name: identity_pool.identity_pool_name,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
