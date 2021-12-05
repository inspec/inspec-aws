require 'helper'
require 'aws_ses_receipt_rule'
require 'aws-sdk-core'

class AWSSESReceiptRuleConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSSESReceiptRule.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSESReceiptRule.new(rule_set_name: '', rule_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSESReceiptRule.new(unexpected: 9) }
  end
end

class AWSSESReceiptRuleSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_receipt_rule
    mock_data = {}
    mock_data[:name] = 'test1'
    mock_data[:enabled] = true
    mock_data[:tls_policy] = 'test1'
    mock_data[:recipients] = ['test1']
    mock_data[:scan_enabled] = true
    data[:data] = { rule: mock_data }
    data[:client] = Aws::SES::Client
    @resp = AWSSESReceiptRule.new(rule_set_name: 'test1', rule_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_rule_exists
    assert @resp.exists?
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_enabled
    assert_equal(@resp.enabled, true)
  end

  def test_tls_policy
    assert_equal(@resp.tls_policy, 'test1')
  end

  def test_recipients
    assert_equal(@resp.recipients, ['test1'])
  end

  def test_scan_enabled
    assert_equal(@resp.scan_enabled, true)
  end
end
