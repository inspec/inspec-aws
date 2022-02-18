require 'helper'
require 'aws_waf_rules'
require 'aws-sdk-core'

class AWSWAFRulesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSWAFRules.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSWAFRules.new(test: 'rubbish') }
  end
end

class AWSWAFRulesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_rules
    mock_data = {}
    mock_data[:rule_id] = 'test_rule_id'
    mock_data[:name] = 'name'
    data[:data] = { rules: [mock_data]}
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFRules.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_rule_exists
    assert @resp.exist?
  end

  def test_rule_ids
    assert_equal(@resp.rule_ids, ['test_rule_id'])
  end

  def test_names
    assert_equal(@resp.names, ['name'])
  end
end