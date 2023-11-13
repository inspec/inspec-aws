require 'aws_backend'

class AwsApiGatewayV2DomainName < AwsResourceBase
  name 'aws_api_gateway_v2_domain_name'
  desc 'Gets a domain name.'
  example <<-EXAMPLE
    describe aws_api_gateway_v2_domain_name(domain_name: 'DOMAIN_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { domain_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(domain_name))
    raise ArgumentError, "#{@__resource_name__}: domain_name must be provided!" if opts[:domain_name].blank?
    @display_name = opts[:domain_name]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_domain_name({ domain_name: opts[:domain_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def domain_name
    return unless exists?
    @res[:domain_name]
  end

  def exists?
    !@res.blank?
  end

  def resource_id
    @res? @res[:domain_name]: @display_name
  end

  def to_s
    "Domain Name: #{@display_name}"
  end

  def api_gateway_domain_names
    domain_name_configurations.map(&:api_gateway_domain_name)
  end

  def certificate_arns
    domain_name_configurations.map(&:certificate_arn)
  end

  def certificate_names
    domain_name_configurations.map(&:certificate_name)
  end

  def certificate_upload_dates
    domain_name_configurations.map(&:certificate_upload_date)
  end

  def domain_name_statuses
    domain_name_configurations.map(&:domain_name_status)
  end

  def domain_name_status_messages
    domain_name_configurations.map(&:domain_name_status_message)
  end

  def endpoint_types
    domain_name_configurations.map(&:endpoint_type)
  end

  def hosted_zone_ids
    domain_name_configurations.map(&:hosted_zone_id)
  end

  def security_policies
    domain_name_configurations.map(&:security_policy)
  end

  def ownership_verification_certificate_arns
    domain_name_configurations.map(&:ownership_verification_certificate_arn)
  end
end
