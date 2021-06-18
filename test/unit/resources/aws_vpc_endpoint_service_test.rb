require 'helper'
require 'aws_vpc_endpoint_service'
require 'aws-sdk-core'
require_relative 'mock/aws_vpc_endpoint_service_mock'

class AwsVPCEndpointServiceConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsVPCEndpointService.new(client_args: { stub_responses: true }) }
  end

  def test_raises_argument_error
    assert_raises(ArgumentError) { AwsVPCEndpointService.new('not-1234') }
  end

  def test_raises_unrecognized_params
    assert_raises(ArgumentError) { AwsVPCEndpointService.new(random: 99) }
  end

  def test_raises_empty_name
    assert_raises(ArgumentError) { AwsVPCEndpointService.new(service_name: '') }
  end
end

class AwsVPCEndpointServiceConstructorIdTest < Minitest::Test
  def setup
    @mock = AwsVPCEndpointServiceMock.new
    @vpc_end_point_service = AwsVPCEndpointService.new(service_name: @mock.service_name,
                                     client_args: { stub_responses: true },
                                     stub_data: [@mock.stub_data])
  end

  def test_service_name
    assert_equal(@vpc_end_point_service.service_name, @mock.service_name)
  end

  def test_service_id
    assert_equal(@vpc_end_point_service.service_id, @mock.service_id)
  end

  def test_service_type
    assert_equal(@vpc_end_point_service.service_type, @mock.service_type)
  end

  def test_availability_zones
    assert_equal(@vpc_end_point_service.availability_zones, @mock.availability_zones)
  end

  def test_owner
    assert_equal(@vpc_end_point_service.owner, @mock.owner)
  end

  def test_base_endpoint_dns_names
    assert_equal(@vpc_end_point_service.base_endpoint_dns_names, @mock.base_endpoint_dns_names)
  end

  def test_private_dns_name
    assert_equal(@vpc_end_point_service.private_dns_name, @mock.private_dns_name)
  end

  def test_vpc_endpoint_policy_supported
    assert(@vpc_end_point_service.vpc_endpoint_policy_supported?)
  end

  def test_acceptance_required
    refute(@vpc_end_point_service.acceptance_required?)
  end

  def test_manages_vpc_endpoints
    refute(@vpc_end_point_service.manages_vpc_endpoints?)
  end

  def test_private_dns_name_verified
    assert(@vpc_end_point_service.private_dns_name_verified?)
  end

  def test_private_dns_name_pending_verification
    refute(@vpc_end_point_service.private_dns_name_pending_verification?)
  end

  def test_interface
    assert(@vpc_end_point_service.interface?)
  end

  def test_gateway
    refute(@vpc_end_point_service.gateway?)
  end

  def test_gateway_load_balancer
    refute(@vpc_end_point_service.gateway_load_balancer?)
  end
end

