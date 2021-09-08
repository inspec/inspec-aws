# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Routes < AwsResourceBase
  name 'aws_api_gatewayv2_routes'
  desc 'Gets the Routes for an API.'

  example "
    describe aws_api_gatewayv2_routes(api_id: 'APIID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:api_gateway_managed, field: :api_gateway_managed)
             .register_column(:api_key_required, field: :api_key_required)
             .register_column(:authorization_scopes, field: :authorization_scopes)
             .register_column(:authorization_types, field: :authorization_type)
             .register_column(:authorizer_ids, field: :authorizer_id)
             .register_column(:model_selection_expressions, field: :model_selection_expression)
             .register_column(:operation_names, field: :operation_name)
             .register_column(:request_models, field: :request_models)
             .register_column(:request_parameters, field: :request_parameters)
             .register_column(:route_ids, field: :route_id)
             .register_column(:route_keys, field: :route_key)
             .register_column(:route_response_selection_expressions, field: :route_response_selection_expression)
             .register_column(:targets, field: :target)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(api_id))
    @query_params = {}
    @query_params[:api_id] = opts[:api_id]
    if opts.key?(:api_id)
      raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
      @query_params[:api_id] = opts[:api_id]
    end
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = '100'
    loop do
      catch_aws_errors do
        @api_response = @aws.apigatewayv2_client.get_routes(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.items.each do |resp|
        rows += [{ api_gateway_managed: resp.api_gateway_managed,
                   expiration_time: resp.expiration_time,
                   authorization_scopes: resp.authorization_scopes,
                   authorization_type: resp.authorization_type,
                   authorizer_id: resp.authorizer_id,
                   model_selection_expression: resp.model_selection_expression,
                   operation_name: resp.operation_name,
                   request_models: resp.request_models,
                   request_parameters: resp.request_parameters,
                   route_id: resp.route_id,
                   route_key: resp.route_key,
                   route_response_selection_expression: resp.route_response_selection_expression,
                   target: resp.target }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
