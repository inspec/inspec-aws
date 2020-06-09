require 'helper'
require 'aws-sdk-core'
require 'aws_albs'
require_relative 'mock/aws_alb_mock'

class AwsAlbsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsAlbs.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsAlbs.new('rubbish') }
  end

  def test_albs_non_existing_for_empty_response
    refute AwsAlbs.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsAlbsTest < Minitest::Test

  def setup
    # Given
    @mock_albs = []
    2.times do
      mock = AwsAlbMock.new
      @mock_albs += mock.alb[:load_balancers]
    end

    stub_data = [{:client => Aws::ElasticLoadBalancingV2::Client,
      :method => :describe_load_balancers,
      :data =>  {load_balancers: @mock_albs}}]

    # When
    @albs = AwsAlbs.new(client_args: { stub_responses: true },
                        stub_data: stub_data)
  end

  def test_lb_names
    assert_equal(@albs.load_balancer_names, [@mock_albs.first[:load_balancer_name], @mock_albs.last[:load_balancer_name]])
  end

  def test_lb_arns
    assert_equal(@albs.load_balancer_arns, [@mock_albs.first[:load_balancer_arn], @mock_albs.last[:load_balancer_arn]])
  end

  def test_lb_load_balancer_addresses
    assert_equal(@albs.load_balancer_addresses.first.first.ip_address, @mock_albs.first[:availability_zones].first[:load_balancer_addresses].first[:ip_address])
    assert_equal(@albs.load_balancer_addresses.last.first.ip_address, @mock_albs.last[:availability_zones].first[:load_balancer_addresses].first[:ip_address])
  end

  def test_lb_canonical_hosted_zone_ids
    assert_equal(@albs.canonical_hosted_zone_ids, [@mock_albs.first[:canonical_hosted_zone_id], @mock_albs.last[:canonical_hosted_zone_id]])
  end

  def test_lb_dns_names
    assert_equal(@albs.dns_names, [@mock_albs.first[:dns_name], @mock_albs.last[:dns_name]])
  end

  def test_lb_schemes
    assert_equal(@albs.schemes, [@mock_albs.first[:scheme], @mock_albs.last[:scheme]])
  end

  def test_lb_security_groups
    assert_equal(@albs.security_groups, [@mock_albs.first[:security_groups], @mock_albs.last[:security_groups]])
  end

  def test_lb_states
    assert_equal(@albs.states.first.code, @mock_albs.first[:state][:code])
    assert_equal(@albs.states.first.reason, @mock_albs.first[:state][:reason])
    assert_equal(@albs.states.last.code, @mock_albs.last[:state][:code])
    assert_equal(@albs.states.last.reason, @mock_albs.last[:state][:reason])
  end

  def test_lb_subnets
    assert_equal(@albs.subnets, [[@mock_albs.first[:availability_zones].first[:subnet_id]], [@mock_albs.last[:availability_zones].first[:subnet_id]]])
  end

  def test_lb_types
    assert_equal(@albs.types, [@mock_albs.first[:type], @mock_albs.last[:type]])
  end

  def test_lb_vpc_ids
    assert_equal(@albs.vpc_ids, [@mock_albs.first[:vpc_id], @mock_albs.last[:vpc_id]])
  end

  def test_lb_zone_names
    assert_equal(@albs.zone_names, [[@mock_albs.first[:availability_zones].first[:zone_name]], [@mock_albs.last[:availability_zones].first[:zone_name]]])
  end

  def test_albs_exists
    assert @albs.exist?
  end
end
