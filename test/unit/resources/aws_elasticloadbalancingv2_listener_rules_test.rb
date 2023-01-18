require 'helper'
require 'aws_elasticloadbalancingv2_listener_rules'
require 'aws-sdk-core'

class AWSElasticLoadBalancingV2ListenerRulesConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2ListenerRules.new( client_args: { stub_responses: true })}
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2ListenerRules.new('rubbish') }
  end
end

class AWSElasticLoadBalancingV2ListenerRulesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_rules
    mock_data = {}
    mock_data[:rule_arn] = 'test1'
    mock_data[:priority] = 'test1'
    mock_data[:is_default] = true
    data[:data] = { :rules => [mock_data] }
    data[:client] = Aws::ElasticLoadBalancingV2::Client
    @listener_rule = AWSElasticLoadBalancingV2ListenerRules.new(listener_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_rules_exists
    assert @listener_rule.exist?
  end

  def test_rule_arns
    assert_equal(@listener_rule.rule_arns, ['test1'])
  end

  def test_priorities
    assert_equal(@listener_rule.priorities, ['test1'])
  end

  def test_is_defaults
    assert_equal(@listener_rule.is_defaults, [true])
  end
end