require "aws_backend"

class AwsVPCEndpointService < AwsResourceBase
  name "aws_vpc_endpoint_service"
  desc "Verifies settings for an AWS VPC End Point Service."

  example "
    describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
      it { should exist }
    end
  "
  SERVICE_TYPES = %w{Interface Gateway GatewayLoadBalancer}.freeze
  BOOLEAN_FLAGS = %i(vpc_endpoint_policy_supported acceptance_required manages_vpc_endpoints).freeze
  PRIVATE_DNS_NAME_VERIFICATION_STATES = %w{pendingVerification verified failed}.freeze

  def self.snakecase(str)
    str.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
  end

  def initialize(opts = {})
    super
    validate_parameters(required: %i(service_name))

    @display_name = @opts[:service_name]
    fetch_response
    create_instance_methods
  end

  def exists?
    !failed_resource? && !!service_detail && !service_detail.empty?
  end

  SERVICE_TYPES.each do |service_type|
    method_name = "#{snakecase(service_type)}?"
    define_method method_name do
      self.service_type == service_type
    end
  end

  BOOLEAN_FLAGS.each do |flag|
    method_name = "#{flag}?"
    define_method method_name do
      service_detail.send(flag)
    end
  end

  PRIVATE_DNS_NAME_VERIFICATION_STATES.each do |verification_state|
    method_name = "private_dns_name_#{snakecase(verification_state)}?"
    define_method method_name do
      service_detail.private_dns_name_verification_state == verification_state
    end
  end

  def has_availability_zones?(zone_name)
    service_detail.availability_zones.include?(zone_name)
  end

  def has_base_endpoint_dns_names?(dns)
    service_detail.base_endpoint_dns_names.include?(dns)
  end

  def resource_id
    @response ? service_detail.service_name : @display_name
  end

  def to_s
    "AWS Service Name #{@display_name}"
  end

  private

  def create_instance_methods
    service_detail_hash = service_detail.to_h
    service_detail_hash[:service_type] = service_detail.service_type.first.service_type
    service_detail_hash.delete(:private_dns_names)
    create_resource_methods(service_detail_hash)
  end

  def fetch_response
    params = {
      service_names: [@opts[:service_name]],
    }
    catch_aws_errors do
      @response = @aws.compute_client.describe_vpc_endpoint_services(params)
    end
  end

  def service_type
    service_detail.service_type.first.service_type
  end

  def service_detail
    raise StandardError, "More than One Route is available" if @response.next_token

    @response.service_details.first
  end
end
