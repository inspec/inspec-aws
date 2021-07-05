require_relative 'aws_base_resource_mock'

class AwsVPCEndpointServiceMock < AwsBaseResourceMock

  attr_reader :service_name, :service_id, :service_type, :availability_zones, :owner, :base_endpoint_dns_names, :private_dns_name,
              :vpc_endpoint_policy_supported, :acceptance_required, :manages_vpc_endpoints, :private_dns_name_verification_state,
              :service_detail
  def initialize
    super
    @service_name = "aws.sagemaker.us-east-2.notebook"
    @service_id="vpce-svc-0f06a44b36daa31c0"
    @service_type = 'Interface'
    @availability_zones= ["us-east-2a", "us-east-2b", "us-east-2c"]
    @owner="amazon"
    @base_endpoint_dns_names=["vpce-svc-0f06a44b36daa31c0.us-east-2.vpce.amazonaws.com", "notebook.us-east-2.vpce.sagemaker.aws"]
    @private_dns_name="*.notebook.us-east-2.sagemaker.aws"
    @vpc_endpoint_policy_supported = true
    @acceptance_required=false
    @manages_vpc_endpoints=false
    @private_dns_name_verification_state="verified"
    @service_detail = {
        service_name: service_name,
        service_id: service_id,
        service_type: [{ service_type: service_type }],
        availability_zones: availability_zones,
        owner: owner,
        base_endpoint_dns_names: base_endpoint_dns_names,
        private_dns_name: private_dns_name,
        private_dns_names: [{ private_dns_name: private_dns_name }],
        vpc_endpoint_policy_supported: vpc_endpoint_policy_supported,
        acceptance_required: acceptance_required,
        manages_vpc_endpoints: manages_vpc_endpoints,
        tags: [],
        private_dns_name_verification_state: private_dns_name_verification_state
      }
  end

  def stub_data
    multiple_stub_data(1)
  end

  def multiple_stub_data(num = 2)
    {
      method: :describe_vpc_endpoint_services,
      client: Aws::EC2::Client,
      data: { service_names: num.times.map{ service_name } , service_details: num.times.map{ service_detail } },
    }
  end
end
