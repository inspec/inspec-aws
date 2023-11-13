require "aws_backend"

class AWSApiGatewayDomainName < AwsResourceBase
  name "aws_api_gateway_domain_name"
  desc "Represents a domain name that is contained in a simpler, more intuitive URL that can be called."
  example <<-EXAMPLE
    describe aws_api_gateway_domain_name(domain_name: 'DOMAIN_NAME') do
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
      resp = @aws.apigateway_client.get_domain_name({ domain_name: opts[:domain_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    @res? "#{@res[:domain_name]}_#{@res[:certificate_arn]}" : ""
  end

  def exists?
    !@res.blank?
  end

  def domain_name
    return unless exists?
    @res[:domain_name]
  end

  def to_s
    "Domain Name: #{@display_name}"
  end

  def endpoint_configuration_types
    endpoint_configuration.map(&:types)
  end

  def endpoint_configuration_vpc_endpoint_ids
    endpoint_configuration.map(&:vpc_endpoint_ids)
  end

  def mutual_tls_authentication_truststore_warnings
    mutual_tls_authentication.map(&:truststore_warnings)
  end
end
