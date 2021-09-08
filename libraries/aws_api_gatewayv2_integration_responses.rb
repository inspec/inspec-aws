# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2IntegrationResponses < AwsResourceBase
  name 'aws_api_gatewayv2_integration_responses'
  desc 'Gets the Integration Responses for an Integration.'

  example "
    describe aws_api_gatewayv2_integration_responses(api_id: 'APIID', integration_id: 'IntegrationID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:content_handling_strategies, field: :content_handling_strategy)
             .register_column(:integration_response_ids, field: :integration_response_id)
             .register_column(:integration_response_keys, field: :integration_response_key)
             .register_column(:response_parameters, field: :response_parameters)
             .register_column(:response_templates, field: :response_templates)
             .register_column(:template_selection_expressions, field: :template_selection_expression)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(api_id integration_id))
    @query_params = {}
    if opts.key?(:api_id)
      raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
      @query_params[:api_id] = opts[:api_id]
    end
    if opts.key?(:api_id)
      raise ArgumentError, "#{@__resource_name__}: integration_id must be provided" unless opts[:integration_id] && !opts[:integration_id].empty?
      @query_params[:integration_id] = opts[:integration_id]
    end
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = '100'
    loop do
      catch_aws_errors do
        @api_response = @aws.apigatewayv2_client.get_integration_responses(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.items.each do |resp|
        rows += [{ content_handling_strategy: resp.content_handling_strategy,
                   integration_response_id: resp.integration_response_id,
                   integration_response_key: resp.integration_response_key,
                   response_parameters: resp.response_parameters,
                   response_templates: resp.response_templates,
                   template_selection_expression: resp.template_selection_expression }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
