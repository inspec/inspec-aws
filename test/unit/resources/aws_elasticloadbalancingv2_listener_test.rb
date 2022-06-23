require 'helper'
require 'aws_elasticloadbalancingv2_listener'
require 'aws-sdk-core'

class AWSElasticLoadBalancingV2ListenerConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2Listener.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2Listener.new(listener_arn: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2Listener.new(unexpected: 9) }
  end
end

class AWSElasticLoadBalancingV2ListenerSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_listeners
    mock_parameter = {}
    mock_parameter[:listener_arn] = 'test1'
    mock_parameter[:load_balancer_arn] = 'test1'
    mock_parameter[:port] = 1
    data[:data] = { listeners: [mock_parameter] }
    data[:client] = Aws::ElasticLoadBalancingV2::Client
    @listeners = AWSElasticLoadBalancingV2Listener.new(listener_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_listeners_exists
    assert @listeners.exists?
  end

  def test_resource_id
    refute_nil(@listeners.resource_id)
    assert_equal(@listeners.resource_id, 'test1')
  end
end