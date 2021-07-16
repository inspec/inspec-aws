require_relative 'aws_base_resource_mock'

class AwsVPCEndpointServicePermissionMock  < AwsBaseResourceMock

  attr_reader :principal_type, :principal

  def initialize
    super
    @principal_type = 'User'
    @principal = 'arn:aws:iam::1123456899:user/chef-server'
    @vpc_endpoint_service_permissions = {
      allowed_principals: [
        {
          principal_type: principal_type,
          principal: principal
        }
      ]
    }
  end

  def stub_data
    {
      method: :describe_vpc_endpoint_service_permissions,
      data: @vpc_endpoint_service_permissions,
      client: Aws::EC2::Client,
    }
  end
end