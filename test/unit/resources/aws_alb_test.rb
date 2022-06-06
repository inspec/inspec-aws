require 'helper'
require 'aws-sdk-core'
require 'aws_alb'
require_relative 'mock/aws_alb_mock'

class AwsAlbConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsAlb.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_load_balancer_arn
    AwsAlb.new(load_balancer_arn: 'alb-arn', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsAlb.new(rubbish: 9) }
  end

  def test_lb_not_existing
    refute AwsAlb.new(load_balancer_arn: 'arn-not-there', client_args: { stub_responses: true }).exists?
  end
end

class AwsAlbTest < Minitest::Test
  def setup
    # Given
    @mock = AwsAlbMock.new
    @mock_alb = @mock.alb[:load_balancers].first
    @mock_alb_listeners = @mock.alb_listeners[:listeners]
    @mock_alb_attributes = @mock.alb_attributes[:attributes]

    # When
    @alb = AwsAlb.new(load_balancer_arn: @mock_alb[:load_balancer_arn],
                      client_args: { stub_responses: true },
                      stub_data: @mock.stub_data)
  end

  def test_resource_id
    refute_nil(@alb.resource_id)
    assert_equal(@alb.resource_id, @mock_alb[:load_balancer_arn])
  end

  def test_lb_name
    assert_equal(@alb.load_balancer_name, @mock_alb[:load_balancer_name])
  end

  def test_lb_arn
    assert_equal(@alb.load_balancer_arn, @mock_alb[:load_balancer_arn])
  end

  def test_lb_load_balancer_addresses
    assert_equal(@alb.load_balancer_addresses.first.ip_address, @mock_alb[:availability_zones].first[:load_balancer_addresses].first[:ip_address])
  end

  def test_lb_canonical_hosted_zone_id
    assert_equal(@alb.canonical_hosted_zone_id, @mock_alb[:canonical_hosted_zone_id])
  end

  def test_lb_dns_name
    assert_equal(@alb.dns_name, @mock_alb[:dns_name])
  end

  def test_lb_scheme
    assert_equal(@alb.scheme, @mock_alb[:scheme])
  end

  def test_lb_security_groups
    assert_equal(@alb.security_groups, @mock_alb[:security_groups])
  end

  def test_lb_state
    assert_equal(@alb.state.code, @mock_alb[:state][:code])
    assert_equal(@alb.state.reason, @mock_alb[:state][:reason])
  end

  def test_lb_subnets
    assert_equal(@alb.subnets.first, @mock_alb[:availability_zones].first[:subnet_id])
  end

  def test_lb_type
    assert_equal(@alb.type, @mock_alb[:type])
  end

  def test_lb_vpc_id
    assert_equal(@alb.vpc_id, @mock_alb[:vpc_id])
  end

  def test_lb_zone_names
    assert_equal(@alb.zone_names.first, @mock_alb[:availability_zones].first[:zone_name])
  end

  def test_lb_ssl_policies
    assert_equal(@alb.ssl_policies, [@mock_alb_listeners.last[:ssl_policy]])
  end

  def test_lb_external_ports
    assert_equal(@alb.external_ports, [@mock_alb_listeners.first[:port], @mock_alb_listeners.last[:port]])
  end

  def test_lb_protocols
    assert_equal(@alb.protocols, [@mock_alb_listeners.first[:protocol], @mock_alb_listeners.last[:protocol]])
  end

  def test_access_log
    assert_equal(true, @alb.access_log_enabled)
  end

  def test_exists
    assert @alb.exists?
  end
end
