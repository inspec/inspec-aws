require 'helper'
require 'aws_waf_sql_injection_match_set'
require 'aws-sdk-core'

class AWSWAFSQLInjectionMatchSetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSWAFSQLInjectionMatchSet.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSWAFSQLInjectionMatchSet.new('', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSWAFSQLInjectionMatchSet.new(unexpected: 9) }
  end
end

class AWSWAFSQLInjectionMatchSetHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_sql_injection_match_set
    mock_data = {}
    mock_data[:sql_injection_match_set_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:sql_injection_match_tuples] = [{ text_transformation: "test1", field_to_match: { type: 'test1', data: 'test1'} }]
    data[:data] = { sql_injection_match_set: mock_data }
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFSQLInjectionMatchSet.new(sql_injection_match_set_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_sql_injection_match_set_exists
    assert @resp.exist?
  end

  def sql_injection_match_set_id
    assert_equal(@resp.sql_injection_match_set_id, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end