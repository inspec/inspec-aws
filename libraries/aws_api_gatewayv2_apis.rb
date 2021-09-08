# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2APIs < AwsResourceBase
  name 'aws_api_gatewayv2_apis'
  desc 'Gets a collection of Api resources.'

  example "
    describe aws_api_gatewayv2_apis do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:api_endpoints, field: :api_endpoint)
             .register_column(:api_gateway_managed, field: :api_gateway_managed)
             .register_column(:api_ids, field: :api_id)
             .register_column(:api_key_selection_expressions, field: :api_key_selection_expression)
             .register_column(:cors_configurations, field: :cors_configuration)
             .register_column(:created_dates, field: :created_date)
             .register_column(:descriptions, field: :description)
             .register_column(:disable_schema_validations, field: :disable_schema_validation)
             .register_column(:disable_execute_api_endpoints, field: :disable_execute_api_endpoint)
             .register_column(:import_infos, field: :import_info)
             .register_column(:names, field: :name)
             .register_column(:protocol_types, field: :protocol_type)
             .register_column(:route_selection_expressions, field: :route_selection_expression)
             .register_column(:tags, field: :tags)
             .register_column(:versions, field: :version)
             .register_column(:warnings, field: :warnings)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.apigatewayv2_client.get_apis(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.items.each do |resp|
        rows += [{ api_endpoint: resp.api_endpoint,
                   api_gateway_managed: resp.api_gateway_managed,
                   api_id: resp.api_id,
                   api_key_selection_expression: resp.api_key_selection_expression,
                   cors_configuration: resp.cors_configuration,
                   created_date: resp.created_date,
                   description: resp.description,
                   disable_schema_validation: resp.disable_schema_validation,
                   disable_execute_api_endpoint: resp.disable_execute_api_endpoint,
                   import_info: resp.import_info,
                   name: resp.name,
                   protocol_type: resp.protocol_type,
                   route_selection_expression: resp.route_selection_expression,
                   tags: resp.tags,
                   version: resp.version,
                   warnings: resp.warnings }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
