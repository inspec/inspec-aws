require 'helper'
require 'aws_vpc_endpoint_service_permission'
require 'aws-sdk-core'
require_relative 'mock/aws_vpc_endpoint_service_permission_mock'

class AwsVPCEndpointServicePermissionConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsVPCEndpointServicePermission.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsVPCEndpointServicePermission.new('fake data') }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsVPCEndpointServicePermission.new(rand_args: 'dummy data') }
  end

  def test_rejects_when_no_principal_is_provided
    assert_raises(ArgumentError) { AwsVPCEndpointServicePermission.new(service_id: 'vpce-svc-04deb776dc2b8e67f') }
  end
end

class AwsVPCEndpointServicePermissionTest < Minitest::Test
  def setup
    @mock = AwsVPCEndpointServicePermissionMock.new
    @service_permission = AwsVPCEndpointServicePermission.new(
      service_id: 'vpce-svc-04deb712345ef67',
      principal: @mock.principal,
      client_args: { stub_responses: true },
      stub_data: [@mock.stub_data],
      )
  end

  def test_exists
    assert(@service_permission.exists?)
  end

  def test_principal
    assert_equal(@service_permission.principal, @mock.principal)
  end

  def test_principal_type
    assert_equal(@service_permission.principal_type, @mock.principal_type)
  end

  def test_principal_type_user
    assert(@service_permission.principal_type_user?)
  end

  def test_principal_type_organization_unit
    refute(@service_permission.principal_type_organization_unit?)
  end

  def test_principal_type_service
    refute(@service_permission.principal_type_service?)
  end
end