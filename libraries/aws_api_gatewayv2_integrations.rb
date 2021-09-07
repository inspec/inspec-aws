# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Integrations < AwsResourceBase
  name 'aws_ec2_vpc_peering_connections'
  desc 'Gets the Integrations for an API.'

  example "
    describe aws_ec2_vpc_peering_connections do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:api_gateway_managed, field: :api_gateway_managed)
             .register_column(:connection_ids, field: :connection_id)
             .register_column(:connection_types, field: :connection_type)
             .register_column(:content_handling_strategies, field: :content_handling_strategy)
             .register_column(:credentials_arns, field: :credentials_arn)
             .register_column(:descriptions, field: :description)
             .register_column(:integration_ids, field: :integration_id)
             .register_column(:integration_methods, field: :integration_method)
             .register_column(:integration_response_selection_expressions, field: :integration_response_selection_expression)
             .register_column(:integration_subtypes, field: :integration_subtype)
             .register_column(:integration_types, field: :integration_type)
             .register_column(:integration_uris, field: :integration_uri)
             .register_column(:passthrough_behaviors, field: :passthrough_behavior)
             .register_column(:payload_format_versions, field: :payload_format_version)
             .register_column(:request_parameters, field: :request_parameters)
             .register_column(:request_templates, field: :request_templates)
             .register_column(:template_selection_expressions, field: :template_selection_expression)
             .register_column(:timeout_in_millis, field: :timeout_in_millis)
             .register_column(:tls_configs, field: :tls_config)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(api_id))
    @query_params = {}
    if opts.key?(:api_id)
      raise ArgumentError, "#{@__resource_name__}: api_id must be provided" unless opts[:api_id] && !opts[:api_id].empty?
      @query_params[:api_id] = opts[:api_id]
    end
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.apigatewayv2_client.get_integrations(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.items.each do |resp|
        rows += [{ api_gateway_managed: resp.api_gateway_managed,
                   connection_id: resp.connection_id,
                   connection_type: resp.connection_type,
                   content_handling_strategy: resp.content_handling_strategy,
                   credentials_arn: resp.credentials_arn,
                   description: resp.description,
                   integration_id: resp.integration_id,
                   integration_method: resp.integration_method,
                   integration_response_selection_expression: resp.integration_response_selection_expression,
                   integration_subtype: resp.integration_subtype,
                   integration_type: resp.integration_type,
                   integration_uri: resp.integration_uri,
                   passthrough_behavior: resp.passthrough_behavior,
                   payload_format_version: resp.payload_format_version,
                   request_parameters: resp.request_parameters,
                   request_templates: resp.request_templates,
                   template_selection_expression: resp.template_selection_expression,
                   timeout_in_millis: resp.timeout_in_millis,
                   tls_config: resp.tls_config }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
