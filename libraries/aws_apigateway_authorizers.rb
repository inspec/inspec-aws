require 'aws_backend'

class AWSApiGatewayAuthorizers < AwsResourceBase
  name 'aws_apigateway_authorizers'
  desc 'Describes the list of Authorizers resource.'
  example <<-EXAMPLE
    describe aws_apigateway_authorizers(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:ids, field: :id)
             .register_column(:names, field: :name)
             .register_column(:types, field: :type)
             .register_column(:provider_arns, field: :provider_arns)
             .register_column(:auth_types, field: :auth_type)
             .register_column(:authorizer_uris, field: :authorizer_uri)
             .register_column(:authorizer_credentials, field: :authorizer_credentials)
             .register_column(:identity_sources, field: :identity_source)
             .register_column(:identity_validation_expressions, field: :identity_validation_expression)
             .register_column(:authorizer_result_ttl_in_seconds, field: :authorizer_result_ttl_in_seconds)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    @query_params[:rest_api_id] = opts[:rest_api_id]
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.apigateway_client.get_authorizers(@query_params).map do |table|
        table.items.map { |table_name| {
          id: table_name.id,
          name: table_name.name,
          type: table_name.type,
          provider_arns: table_name.provider_arns,
          auth_type: table_name.auth_type,
          authorizer_uri: table_name.authorizer_uri,
          authorizer_credentials: table_name.authorizer_credentials,
          identity_source: table_name.identity_source,
          identity_validation_expression: table_name.identity_validation_expression,
          authorizer_result_ttl_in_seconds: table_name.authorizer_result_ttl_in_seconds,
        }
        }
      end.flatten
    end
  end
end
