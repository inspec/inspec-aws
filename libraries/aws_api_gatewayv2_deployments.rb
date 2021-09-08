# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Deployments < AwsResourceBase
  name 'aws_api_gatewayv2_deployments'
  desc 'Gets the Deployments for an API.'

  example "
    describe aws_api_gatewayv2_deployments(api_id: 'APIID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:auto_deployed, field: :auto_deployed)
             .register_column(:created_dates, field: :created_date)
             .register_column(:deployment_ids, field: :deployment_id)
             .register_column(:deployment_statuses, field: :deployment_status)
             .register_column(:deployment_status_messages, field: :deployment_status_message)
             .register_column(:descriptions, field: :description)
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
        @api_response = @aws.apigatewayv2_client.get_deployments(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.items.each do |resp|
        rows += [{ auto_deployed: resp.auto_deployed,
                   created_date: resp.created_date,
                   deployment_id: resp.deployment_id,
                   deployment_status: resp.deployment_status,
                   deployment_status_message: resp.deployment_status_message,
                   description: resp.description }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
