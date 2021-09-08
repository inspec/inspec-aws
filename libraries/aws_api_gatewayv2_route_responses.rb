# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2RouteResponses < AwsResourceBase
  name 'aws_api_gatewayv2_route_responses'
  desc 'Gets the Route Responses for a Route.'

  example "
    describe aws_api_gatewayv2_route_responses(api_id: 'APIID', route_id: 'RouteID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:model_selection_expressions, field: :model_selection_expression)
             .register_column(:response_models, field: :response_models)
             .register_column(:response_parameters, field: :response_parameters)
             .register_column(:route_response_ids, field: :route_response_id)
             .register_column(:route_response_keys, field: :route_response_key)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(api_id route_id))
    if opts.key?(:api_id)
      raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
      @query_params[:api_id] = opts[:api_id]
    end
    if opts.key?(:route_id)
      raise ArgumentError, "#{@__resource_name__}: route_id must be provided" unless opts[:route_id] && !opts[:route_id].empty?
      @query_params[:route_id] = opts[:route_id]
    end
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:max_results] = '100'
    loop do
      catch_aws_errors do
        @api_response = @aws.apigatewayv2_client.get_route_responses(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.items.each do |resp|
        rows += [{ model_selection_expression: resp.model_selection_expression,
                   response_models: resp.response_models,
                   response_parameters: resp.response_parameters,
                   route_response_id: resp.route_response_id,
                   route_response_key: resp.route_response_key }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
