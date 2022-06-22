require 'helper'
require 'aws_elasticloadbalancingv2_listener_rule'
require 'aws-sdk-core'

class AWSElasticLoadBalancingV2ListenerRuleConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2ListenerRule.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2ListenerRule.new(rule_arns: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2ListenerRule.new(unexpected: 9) }
  end
end

class AWSElasticLoadBalancingV2ListenerRuleSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_rules
    mock_parameter = {}
    mock_parameter[:rule_arn] = 'test1'
    mock_parameter[:priority] = 'test1'
    mock_parameter[:is_default] = false
    data[:data] = { rules: [mock_parameter] }
    data[:client] = Aws::ElasticLoadBalancingV2::Client
    @rules = AWSElasticLoadBalancingV2ListenerRule.new(rule_arns: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_rules_exists
    assert @rules.exists?
  end

  def test_rule_arn
    assert_equal(@rules.rule_arn, 'test1')
  end

  def test_priority
    assert_equal(@rules.priority, 'test1')
  end

  def test_is_default
    assert_equal(@rules.is_default, false)
  end

  def test_resource_id
    refute_nil(@rules.resource_id)
    assert_equal(@rules.resource_id, 'test1')
  end

end