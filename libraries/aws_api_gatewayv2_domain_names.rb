# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2DomainNames < AwsResourceBase
  name 'aws_api_gatewayv2_domain_names'
  desc 'Gets the domain names for an AWS account.'

  example "
    describe aws_api_gatewayv2_domain_names do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:api_mapping_selection_expressions, field: :api_mapping_selection_expression)
             .register_column(:domain_names, field: :domain_name)
             .register_column(:domain_name_configurations, field: :domain_name_configurations)
             .register_column(:configurations_api_gateway_domain_names, field: :configurations_api_gateway_domain_names)
             .register_column(:configurations_certificate_arns, field: :configurations_certificate_arns)
             .register_column(:configurations_certificate_names, field: :configurations_certificate_names)
             .register_column(:configurations_certificate_upload_dates, field: :configurations_certificate_upload_dates)
             .register_column(:configurations_domain_name_statuses, field: :configurations_domain_name_statuses)
             .register_column(:configurations_domain_name_status_messages, field: :configurations_domain_name_status_messages)
             .register_column(:configurations_endpoint_types, field: :configurations_endpoint_types)
             .register_column(:configurations_hosted_zone_ids, field: :configurations_hosted_zone_ids)
             .register_column(:configurations_security_policies, field: :configurations_security_policies)
             .register_column(:mutual_tls_authentication_truststore_uris, field: :mutual_tls_authentication_truststore_uris)
             .register_column(:mutual_tls_authentication_truststore_versions, field: :mutual_tls_authentication_truststore_versions)
             .register_column(:mutual_tls_authentication_truststore_warnings, field: :mutual_tls_authentication_truststore_warnings)
             .register_column(:tags, field: :tags)
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
        @api_response = @aws.apigatewayv2_client.get_domain_names(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.vpc_peering_connections.each do |resp|
        rows += [{ api_mapping_selection_expression: resp.api_mapping_selection_expression,
                   domain_name: resp.domain_name,
                   domain_name_configurations: resp.domain_name_configurations,
                   configurations_api_gateway_domain_names: resp.domain_name_configurations.map(&:api_gateway_domain_name),
                   configurations_certificate_arns: resp.domain_name_configurations.map(&:certificate_arn),
                   configurations_certificate_names: resp.domain_name_configurations.map(&:certificate_name),
                   configurations_certificate_upload_dates: resp.domain_name_configurations.map(&:certificate_upload_date),
                   configurations_domain_name_statuses: resp.domain_name_configurations.map(&:domain_name_status),
                   configurations_domain_name_status_messages: resp.domain_name_configurations.map(&:domain_name_status_message),
                   configurations_endpoint_types: resp.domain_name_configurations.map(&:endpoint_type),
                   configurations_hosted_zone_ids: resp.domain_name_configurations.map(&:hosted_zone_id),
                   configurations_security_policies: resp.domain_name_configurations.map(&:security_policy),
                   mutual_tls_authentication_truststore_uris: resp.mutual_tls_authentication.map(&:truststore_uri),
                   mutual_tls_authentication_truststore_versions: resp.mutual_tls_authentication.map(&:truststore_version),
                   mutual_tls_authentication_truststore_warnings: resp.mutual_tls_authentication.map(&:truststore_warnings),
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
