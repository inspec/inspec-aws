# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Stages < AwsResourceBase
  name 'aws_api_gatewayv2_stages'
  desc 'Gets the Stages for an API.'

  example "
    describe aws_api_gatewayv2_stages(api_id: 'APIID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:access_log_settings, field: :access_log_settings)
             .register_column(:api_gateway_managed, field: :api_gateway_managed)
             .register_column(:auto_deploys, field: :auto_deploy)
             .register_column(:client_certificate_ids, field: :client_certificate_id)
             .register_column(:created_dates, field: :created_date)
             .register_column(:default_route_settings, field: :default_route_settings)
             .register_column(:deployment_ids, field: :deployment_id)
             .register_column(:descriptions, field: :description)
             .register_column(:last_deployment_status_messages, field: :last_deployment_status_message)
             .register_column(:last_updated_dates, field: :last_updated_date)
             .register_column(:route_settings, field: :route_settings)
             .register_column(:stage_names, field: :stage_name)
             .register_column(:stage_variables, field: :stage_variables)
             .register_column(:tags, field: :tags)
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
        @api_response = @aws.apigatewayv2_client.get_stages(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.items.each do |resp|
        rows += [{ access_log_settings: resp.access_log_settings,
                   api_gateway_managed: resp.api_gateway_managed,
                   auto_deploy: resp.auto_deploy,
                   client_certificate_id: resp.client_certificate_id,
                   created_date: resp.created_date,
                   default_route_settings: resp.default_route_settings,
                   deployment_id: resp.deployment_id,
                   description: resp.description,
                   last_deployment_status_message: resp.last_deployment_status_message,
                   last_updated_date: resp.last_updated_date,
                   route_settings: resp.route_settings,
                   stage_name: resp.stage_name,
                   stage_variables: resp.stage_variables,
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
