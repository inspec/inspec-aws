# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayMethods < AwsResourceBase
  name 'aws_api_gateway_methods'
  desc 'Describes a Method Response resource.'
  example `
    describe aws_api_gateway_methods(rest_api_id: "test", resource_id: 'test', http_method: 'test', status_code: 'test') do
      it { should exist }
    end
  `

  attr_reader :table

  FilterTable.create
             .register_column(:status_codes,                                    field: :status_code)
             .register_column(:response_parameters,                             field: :response_parameters)
             .register_column(:response_models,                                 field: :response_models)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id resource_id http_method status_code))
    @query_params = {}
    @query_params[:rest_api_id] = opts[:rest_api_id]
    @query_params[:resource_id] = opts[:resource_id]
    @query_params[:http_method] = opts[:http_method]
    @query_params[:status_code] = opts[:status_code]
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: resource_id must be provided" unless opts[:resource_id] && !opts[:resource_id].empty?
    raise ArgumentError, "#{@__resource_name__}: http_method must be provided" unless opts[:http_method] && !opts[:http_method].empty?
    raise ArgumentError, "#{@__resource_name__}: status_code must be provided" unless opts[:status_code] && !opts[:status_code].empty?
    @query_params[:rest_api_id] = opts[:rest_api_id]
    @query_params[:resource_id] = opts[:resource_id]
    @query_params[:http_method] = opts[:http_method]
    @query_params[:status_code] = opts[:status_code]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    # @query_params[:max_results] = 1000
    loop do
      catch_aws_errors do
        @api_response = @aws.autoscaling_client.get_method_response(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.each do |resp|
        rows += [{
          status_code: resp.status_code,
          response_parameters: resp.response_parameters,
          response_models: resp.response_models,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
