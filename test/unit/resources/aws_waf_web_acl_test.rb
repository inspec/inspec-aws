require 'helper'
require 'aws_waf_web_acl'
require 'aws-sdk-core'

class AWSWAFWebACLConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSWAFWebACL.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSWAFWebACL.new('', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSWAFWebACL.new(unexpected: 9) }
  end
end

class AWSWAFWebACLHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_web_acl
    mock_data = {}
    mock_data[:web_acl_id] = 'test1'
    mock_data[:web_acl_arn] = 'test1'
    mock_data[:default_action] = { type: 'test1'}
    mock_data[:name] = 'test1'
    mock_data[:rules] = [{ priority: 1, action: { type: 'test1'}, override_action: { type: 'test1'}, type: "test1",rule_id: "test1" }]
    mock_data[:web_acl_arn]='test1'
    data[:data] = { web_acl: mock_data }
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFWebACL.new(web_acl_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_web_acl_exists
    assert @resp.exist?
  end

  def test_web_acl_id
    assert_equal(@resp.web_acl_id, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end