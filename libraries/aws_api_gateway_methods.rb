require "aws_backend"

class AWSApiGatewayMethods < AwsResourceBase
  name "aws_api_gateway_methods"
  desc "Describe an existing Method resource."
  example <<-EXAMPLE
    describe aws_api_gateway_methods(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'GET') do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
    .register_column(:http_methods,                                    field: :http_method)
    .register_column(:authorization_types,                             field: :authorization_type)
    .register_column(:authorizer_ids,                                  field: :authorizer_id)
    .register_column(:api_key_required,                                field: :api_key_required)
    .register_column(:request_validator_ids,                           field: :request_validator_id)
    .register_column(:operation_names,                                 field: :operation_name)
    .register_column(:request_parameters,                              field: :request_parameters)
    .register_column(:request_models,                                  field: :request_models)
    .register_column(:method_responses,                                field: :method_responses)
    .register_column(:method_integrations,                             field: :method_integration)
    .register_column(:authorization_scopes,                            field: :authorization_scopes)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id resource_id http_method))
    @query_params = {}
    @query_params[:rest_api_id] = opts[:rest_api_id]
    @query_params[:resource_id] = opts[:resource_id]
    @query_params[:http_method] = opts[:http_method]
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: resource_id must be provided" unless opts[:resource_id] && !opts[:resource_id].empty?
    raise ArgumentError, "#{@__resource_name__}: http_method must be provided" unless opts[:http_method] && !opts[:http_method].empty?
    @query_params[:rest_api_id] = opts[:rest_api_id]
    @query_params[:resource_id] = opts[:resource_id]
    @query_params[:http_method] = opts[:http_method]
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.apigateway_client.get_method(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.map(&:to_h)
  end
end
