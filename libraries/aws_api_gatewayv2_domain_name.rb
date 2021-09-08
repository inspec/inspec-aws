# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2DomainName < AwsResourceBase
  name 'aws_api_gatewayv2_domain_name'
  desc 'Gets a domain name.'

  example "
    describe aws_api_gatewayv2_domain_name(domain_name: 'DomainName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { domain_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(domain_name))
    raise ArgumentError, "#{@__resource_name__}: domain_name must be provided" unless opts[:domain_name] && !opts[:domain_name].empty?
    @display_name = opts[:domain_name]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_domain_name({ domain_name: opts[:domain_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def domain_name
    return nil unless exists?
    @res[:domain_name]
  end

  def configurations_api_gateway_domain_names
    domain_name_configurations.map(&:api_gateway_domain_name)
  end

  def configurations_certificate_arns
    domain_name_configurations.map(&:certificate_arn)
  end

  def configurations_certificate_names
    domain_name_configurations.map(&:certificate_name)
  end

  def configurations_certificate_upload_dates
    domain_name_configurations.map(&:certificate_upload_date)
  end

  def configurations_domain_name_statuses
    domain_name_configurations.map(&:domain_name_status)
  end

  def configurations_domain_name_status_messages
    domain_name_configurations.map(&:domain_name_status_message)
  end

  def configurations_endpoint_types
    domain_name_configurations.map(&:endpoint_type)
  end

  def configurations_hosted_zone_ids
    domain_name_configurations.map(&:hosted_zone_id)
  end

  def configurations_security_policies
    domain_name_configurations.map(&:security_policy)
  end

  def mutual_tls_authentication_truststore_uris
    mutual_tls_authentication.map(&:truststore_uri)
  end

  def mutual_tls_authentication_truststore_versions
    mutual_tls_authentication.map(&:truststore_version)
  end

  def mutual_tls_authentication_truststore_warnings
    mutual_tls_authentication.map(&:truststore_warnings)
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Domain Name: #{@display_name}"
  end
end
