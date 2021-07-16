require 'helper'
require 'aws_elasticloadbalancingv2_listeners'
require 'aws-sdk-core'

class AWSElasticLoadBalancingV2ListenersConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSElasticLoadBalancingV2Listeners.new(load_balancer_arn: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2Listeners.new('rubbish') }
  end

  def test_work_groups_non_existing_for_empty_response
    refute AWSElasticLoadBalancingV2Listeners.new(load_balancer_arn: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSElasticLoadBalancingV2ListenersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_listeners
    mock_data = {}
    mock_data[:listener_arn] = 'test1'
    mock_data[:load_balancer_arn] = 'test1'
    mock_data[:port] = 1
    data[:data] = { :listeners => [mock_data] }
    data[:client] = Aws::ElasticLoadBalancingV2::Client
    @listeners = AWSElasticLoadBalancingV2Listeners.new(load_balancer_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_listeners_exists
    assert @listeners.exist?
  end

  def test_listener_arns
    assert_equal(@listeners.listener_arns, ['test1'])
  end

  def test_load_balancer_arns
    assert_equal(@listeners.load_balancer_arns, ['test1'])
  end

  def test_ports
    assert_equal(@listeners.ports, [1])
  end
end