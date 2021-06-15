require 'helper'
require 'aws_elasticloadbalancingv2_load_balancers'
require 'aws-sdk-core'

class AWSElasticLoadBalancingV2LoadBalancersConstructorTest < Minitest::Test

  def test_empty_params_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2LoadBalancers.new(load_balancer_arn: 'test1', client_args: { stub_responses: true })}
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2LoadBalancers.new('rubbish') }
  end

  def test_work_groups_non_existing_for_empty_response
    refute AWSElasticLoadBalancingV2LoadBalancers.new( client_args: { stub_responses: true }).exist?
  end
end

class AWSElasticLoadBalancingV2LoadBalancersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_load_balancers
    mock_data = {}
    mock_data[:load_balancer_arn] = 'test1'
    mock_data[:dns_name] = 'test1'
    mock_data[:canonical_hosted_zone_id] = 'test1'
    data[:data] = { :load_balancers => [mock_data] }
    data[:client] = Aws::ElasticLoadBalancingV2::Client
    @load_balancers = AWSElasticLoadBalancingV2LoadBalancers.new( client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_load_balancers_exists
    assert @load_balancers.exist?
  end

  def test_load_balancer_arns
    assert_equal(@load_balancers.load_balancer_arns, ['test1'])
  end

  def test_dns_names
    assert_equal(@load_balancers.dns_names, ['test1'])
  end

  def test_canonical_hosted_zone_ids
    assert_equal(@load_balancers.canonical_hosted_zone_ids, ['test1'])
  end
end