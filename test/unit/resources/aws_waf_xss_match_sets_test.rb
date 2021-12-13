require 'helper'
require 'aws_waf_xss_match_sets'
require 'aws-sdk-core'

class AWSWAFXSSMatchSetsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSWAFXSSMatchSets.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSWAFXSSMatchSets.new(test: 'dummy') }
  end
end

class AWSWAFXSSMatchSetsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_xss_match_sets
    mock_data = {}
    mock_data[:xss_match_sets] = [{ xss_match_set_id: 'xss_match_set_id', name: 'name' }]
    data[:data] = mock_data
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFXSSMatchSets.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_xss_match_set_exists
    assert @resp.exist?
  end

  def test_xss_match_set_ids
    assert_equal(@resp.xss_match_set_ids, ['xss_match_set_id'])
  end
end