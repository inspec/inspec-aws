require "aws_backend"

class AWSApiGatewayRestApis < AwsResourceBase
  name "aws_api_gateway_restapis"
  desc "Lists the RestApis resources for your collection."
  example <<-EXAMPLE
    describe aws_api_gateway_restapis do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
    .register_column(:ids,                                             field: :id)
    .register_column(:names,                                           field: :name)
    .register_column(:descriptions,                                    field: :description)
    .register_column(:created_dates,                                   field: :created_date)
    .register_column(:versions,                                        field: :version)
    .register_column(:warnings,                                        field: :warnings)
    .register_column(:binary_media_types,                              field: :binary_media_types)
    .register_column(:minimum_compression_sizes,                       field: :minimum_compression_size)
    .register_column(:api_key_sources,                                 field: :api_key_source)
    .register_column(:endpoint_configurations,                         field: :endpoint_configuration)
    .register_column(:policies,                                        field: :policy)
    .register_column(:tags,                                            field: :tags)
    .register_column(:disable_execute_api_endpoints,                   field: :disable_execute_api_endpoint)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @query_params = {}
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.apigateway_client.get_rest_apis(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.items.map(&:to_h)
  end
end
