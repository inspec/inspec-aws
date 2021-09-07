# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2Authorizers < AwsResourceBase
  name 'aws_api_gatewayv2_authorizers'
  desc 'Gets the Authorizers for an API.'

  example "
    describe aws_api_gatewayv2_authorizers(api_id: 'api_id') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:authorizer_credentials_arns, field: :authorizer_credentials_arn)
             .register_column(:authorizer_ids, field: :authorizer_id)
             .register_column(:authorizer_result_ttl_in_seconds, field: :authorizer_result_ttl_in_seconds)
             .register_column(:authorizer_types, field: :authorizer_type)
             .register_column(:authorizer_uris, field: :authorizer_uri)
             .register_column(:identity_sources, field: :identity_source)
             .register_column(:identity_validation_expressions, field: :identity_validation_expression)
             .register_column(:jwt_configurations, field: :jwt_configuration)
             .register_column(:names, field: :name)
             .register_column(:authorizer_payload_format_versions, field: :authorizer_payload_format_version)
             .register_column(:enable_simple_responses, field: :enable_simple_responses)
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
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.apigatewayv2_client.get_authorizers(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.items.each do |resp|
        rows += [{ authorizer_credentials_arn: resp.authorizer_credentials_arn,
                   authorizer_id: resp.authorizer_id,
                   authorizer_result_ttl_in_seconds: resp.authorizer_result_ttl_in_seconds,
                   authorizer_type: resp.authorizer_type,
                   authorizer_uri: resp.authorizer_uri,
                   identity_source: resp.identity_source,
                   identity_validation_expression: resp.identity_validation_expression,
                   jwt_configuration: resp.jwt_configuration,
                   name: resp.name,
                   authorizer_payload_format_version: resp.authorizer_payload_format_version,
                   enable_simple_responses: resp.enable_simple_responses }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
