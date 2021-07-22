require 'helper'
require 'aws_vpc_endpoint_service_permissions'
require 'aws-sdk-core'
require_relative 'mock/aws_vpc_endpoint_service_permission_mock'

class AwsVPCEndpointServicePermissionsConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsVPCEndpointServicePermissions.new(client_args: { stub_responses: true }) }
  end
end

class AwsVPCEndpointServicePermissionsTest < Minitest::Test
  def setup
    @mock = AwsVPCEndpointServicePermissionMock.new
    # Create stub gateways with mock data.
    @service_permissions = AwsVPCEndpointServicePermissions.new(
      service_id: 'vpce-svc-04deb776dc2b8e67f',
      client_args: { stub_responses: true },
      stub_data: [@mock.stub_data],
      )
  end

  def test_principals
    assert_includes(@service_permissions.principals, @mock.principal)
  end

  def test_principal_types
    assert_includes(@service_permissions.principal_types, @mock.principal_type)
  end
end