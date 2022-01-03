require 'helper'
require 'aws_waf_sql_injection_match_sets'
require 'aws-sdk-core'

class AWSWAFSQLInjectionMatchSetsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSWAFSQLInjectionMatchSets.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSWAFSQLInjectionMatchSets.new(test: 'rubbish') }
  end
end

class AWSWAFSQLInjectionMatchSetsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_sql_injection_match_sets
    mock_data = {}
    mock_data[:sql_injection_match_sets] = [{ sql_injection_match_set_id: 'sql_injection_match_set_id', name: 'name' }]
    data[:data] = mock_data
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFSQLInjectionMatchSets.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_sql_injection_match_set_exists
    assert @resp.exist?
  end

  def test_sql_injection_match_set_ids
    assert_equal(@resp.sql_injection_match_set_ids, ['sql_injection_match_set_id'])
  end
end