# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Models < AwsResourceBase
  name 'aws_api_gatewayv2_models'
  desc 'Gets the Models for an API.'

  example "
    describe aws_api_gatewayv2_models(api_id: 'APIID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:content_types, field: :content_type)
             .register_column(:descriptions, field: :description)
             .register_column(:model_ids, field: :model_id)
             .register_column(:names, field: :name)
             .register_column(:schemas, field: :schema)
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
        @api_response = @aws.apigatewayv2_client.get_models(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.items.each do |resp|
        rows += [{ content_type: resp.content_type,
                   description: resp.description,
                   model_id: resp.model_id,
                   name: resp.name,
                   schema: resp.schema }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
