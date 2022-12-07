require 'helper'
require 'aws_waf_rule'
require 'aws-sdk-core'

class AWSWAFRuleConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSWAFRule.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSWAFRule.new('', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSWAFRule.new(unexpected: 9) }
  end
end

class AWSWAFRuleHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_rule
    mock_data = {}
    mock_data[:rule_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:metric_name] = 'test1'
    mock_data[:predicates ] = [{ negated: true, type: 'test1', data_id: 'test1' }]
    data[:data] = { rule: mock_data }
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFRule.new(rule_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_rule_exists
    assert @resp.exist?
  end

  def test_rule_id
    assert_equal(@resp.rule_id, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end