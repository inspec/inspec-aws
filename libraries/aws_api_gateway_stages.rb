require 'aws_backend'

class AWSApiGatewayStages < AwsResourceBase
  name 'aws_api_gateway_stages'
  desc 'Gets information about a Stages collection.'
  example <<-EXAMPLE
    describe aws_api_gateway_stages(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:stage_names,                     field: :stage_name)
             .register_column(:deployment_ids,                  field: :deployment_id)
             .register_column(:created_dates,                   field: :created_date)
             .register_column(:descriptions,                    field: :description)
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
      @resp = @aws.apigateway_client.get_stages(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.item.map(&:to_h)
  end
end
