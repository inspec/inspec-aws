# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2APIMappings < AwsResourceBase
  name 'aws_api_gatewayv2_api_mappings'
  desc 'Gets API mappings.'

  example "
    describe aws_api_gatewayv2_api_mappings(domain_name: 'DomainName') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:api_ids, field: :api_id)
             .register_column(:api_mapping_ids, field: :api_mapping_id)
             .register_column(:api_mapping_keys, field: :api_mapping_key)
             .register_column(:stages, field: :stage)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(domain_name))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: domain_name must be provided" unless opts[:domain_name] && !opts[:domain_name].empty?
    @query_params[:domain_name] = opts[:domain_name]
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.apigatewayv2_client.get_api_mappings(@query_params).map do |table|
        table.items.map { |table_name| {
          api_id: table_name.api_id,
          api_mapping_id: table_name.api_mapping_id,
          api_mapping_key: table_name.api_mapping_key,
          stage: table_name.stage,
        }
        }
      end.flatten
    end
  end
end
