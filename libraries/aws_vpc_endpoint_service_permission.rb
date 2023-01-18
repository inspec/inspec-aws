require "aws_backend"

class AwsVPCEndpointServicePermission < AwsResourceBase
  name "aws_vpc_endpoint_service_permission"
  desc "Describes the principal (service consumers) that are permitted to discover your VPC endpoint service."
  example "
    describe aws_vpc_endpoint_service_permission(service_id: 'vpce-svc-04deb776dc2b8e67f', principal: 'arn:aws:iam::112758395563:user/chef-server') do
      it { should exist }
    end
  "

  PRINCIPAL_TYPES = %w{All Service OrganizationUnit Account User Role}.freeze

  PRINCIPAL_TYPES.each do |principal_type|
    method_name = "principal_type_#{principal_type.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase}?"
    define_method method_name do
      allowed_principal.principal_type == principal_type
    end
  end

  def initialize(opts)
    super(opts)
    validate_parameters(required: %i(service_id principal))
    filters = {
      filters: [
        name: "principal",
        values: [opts[:principal]],
      ],
    }
    @params = opts.slice(:service_id).merge(filters)
    fetch_data
    create_resource_methods(allowed_principal.to_h)
  end

  def exists?
    !failed_resource? && !!allowed_principal && !allowed_principal.empty?
  end

  def resource_id
    "#{@opts ? @opts[:service_id] : ""}_#{@opts ? @opts[:principal] : ""}"
  end

  def to_s
    "VPN Endpoint Service ID: #{@opts[:service_id]} and Permission Principal: #{@opts[:principal]}"
  end

  private

  def fetch_data
    @api_response = catch_aws_errors do
      @aws.compute_client.describe_vpc_endpoint_service_permissions(@params)
    end
  end

  def allowed_principal
    return unless @api_response

    @api_response.allowed_principals&.first
  end
end
