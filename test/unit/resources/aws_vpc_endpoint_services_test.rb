require 'helper'
require 'aws_vpc_endpoint_services'
require 'aws-sdk-core'
require_relative 'mock/aws_vpc_endpoint_service_mock'

class AwsVPCEndpointServicesConstructorTest < Minitest::Test
  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsVPCEndpointServices.new('random') }
  end
end

class AwsVPCEndpointServicesConstructorIDTest < Minitest::Test
  def setup
    @mock = AwsVPCEndpointServiceMock.new

    @vpc_end_point_services = AwsVPCEndpointServices.new(client_args: { stub_responses: true },
                                       stub_data: [@mock.multiple_stub_data])
  end

  def test_exists
    assert(@vpc_end_point_services.exist?)
  end

  def test_service_ids
    assert_includes(@vpc_end_point_services.service_ids, @mock.service_id)
  end

  def test_service_types
    assert_includes(@vpc_end_point_services.service_types, @mock.service_type)
  end

  def test_availability_zones
    assert_includes(@vpc_end_point_services.availability_zones, @mock.availability_zones.first)
  end

  def test_owners
    assert_includes(@vpc_end_point_services.owners, @mock.owner)
  end

  def test_base_endpoint_dns_names
    assert_includes(@vpc_end_point_services.base_endpoint_dns_names, @mock.base_endpoint_dns_names.first)
  end

  def test_private_dns_names
    assert_includes(@vpc_end_point_services.private_dns_names, @mock.private_dns_name)
  end

  def test_vpc_endpoint_policy_supported
    assert_includes(@vpc_end_point_services.vpc_endpoint_policy_supported, @mock.vpc_endpoint_policy_supported)
  end

  def test_acceptance_required
    assert_includes(@vpc_end_point_services.acceptance_required, @mock.acceptance_required)
  end

  def test_manages_vpc_endpoints
    assert_includes(@vpc_end_point_services.manages_vpc_endpoints, @mock.manages_vpc_endpoints)
  end

  def test_private_dns_name_verification_states
    assert_includes(@vpc_end_point_services.private_dns_name_verification_states, @mock.private_dns_name_verification_state)
  end
end

