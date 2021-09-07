# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2APIMappings < AwsResourceBase
  name 'aws_api_gatewayv2_api_mappings'
  desc 'Gets API mappings.'

  example "
    describe aws_api_gatewayv2_api_mappings(domain_name: 'domain_name') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:api_ids, field: :api_id)
             .register_column(:api_mapping_ids, field: :api_mapping_id)
             .register_column(:api_mapping_key, field: :api_mapping_key)
             .register_column(:stages, field: :stage)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(domain_name))
    @query_params = {}
    @query_params[:domain_name] = opts[:domain_name]
    if opts.key?(:domain_name)
      raise ArgumentError, "#{@__resource_name__}: domain_name must be provided" unless opts[:domain_name] && !opts[:domain_name].empty?
      @query_params[:domain_name] = opts[:domain_name]
    end
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.apigatewayv2_client.get_api_mappings(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.items.each do |resp|
        rows += [{ api_id: resp.api_id,
                   api_mapping_id: resp.api_mapping_id,
                   api_mapping_key: resp.api_mapping_key,
                   stage: resp.stage }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
