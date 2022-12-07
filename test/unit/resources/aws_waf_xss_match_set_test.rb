require 'helper'
require 'aws_waf_xss_match_set'
require 'aws-sdk-core'

class AWSWAFXSSMatchSetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSWAFXSSMatchSet.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSWAFXSSMatchSet.new('', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSWAFXSSMatchSet.new(unexpected: 9) }
  end
end

class AWSWAFXSSMatchSetHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_xss_match_set
    mock_data = {}
    mock_data[:xss_match_set_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:xss_match_tuples] = [{ text_transformation: "test1", field_to_match: { type: 'test1', data: 'test1'} }]
    data[:data] = { xss_match_set: mock_data }
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFXSSMatchSet.new(xss_match_set_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_sql_injection_match_set_exists
    assert @resp.exist?
  end

  def xss_match_set_id
    assert_equal(@resp.xss_match_set_id, 'test1')
  end

  def test_sql_injection_match_set_name
    assert_equal(@resp.name, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end