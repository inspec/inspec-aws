require 'helper'
require 'aws_elasticloadbalancingv2_load_balancer'
require 'aws-sdk-core'

class AWSElasticLoadBalancingV2LoadBalancerConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2LoadBalancer.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2LoadBalancer.new(load_balancer_arn: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2LoadBalancer.new(unexpected: 9) }
  end
end

class AWSElasticLoadBalancingV2LoadBalancerSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_load_balancers
    mock_parameter = {}
    mock_parameter[:load_balancer_arn] = 'test1'
    mock_parameter[:dns_name] = 'test1'
    mock_parameter[:canonical_hosted_zone_id] = 'test1'
    data[:data] = { load_balancers: [mock_parameter] }
    data[:client] = Aws::ElasticLoadBalancingV2::Client
    @load_balancers = AWSElasticLoadBalancingV2LoadBalancer.new(load_balancer_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_load_balancers_exists
    assert @load_balancers.exists?
  end

  def test_load_balancer_arn
    assert_equal(@load_balancers.load_balancer_arn, 'test1')
  end

  def test_dns_name
    assert_equal(@load_balancers.dns_name, 'test1')
  end

  def test_canonical_hosted_zone_id
    assert_equal(@load_balancers.canonical_hosted_zone_id, 'test1')
  end
end