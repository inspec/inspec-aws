require 'aws_backend'

class AWSApiGatewayDeployments < AwsResourceBase
  name 'aws_api_gateway_deployments'
  desc 'Gets information about a Deployments collection.'
  example <<-EXAMPLE
    describe aws_api_gateway_deployments(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:ids,                                         field: :id)
             .register_column(:descriptions,                                field: :description)
             .register_column(:created_dates,                               field: :created_date)
             .register_column(:api_summaries,                               field: :api_summary)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id))
    @query_params = {}
    @query_params[:rest_api_id] = opts[:rest_api_id]
    if opts.key?(:rest_api_id)
      raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
      @query_params[:rest_api_id] = opts[:rest_api_id]
    end
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.apigateway_client.get_deployments(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.items.map(&:to_h)
  end
end
