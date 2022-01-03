require 'helper'
require 'aws_waf_byte_match_sets'
require 'aws-sdk-core'

class AWSWAFByteMatchSetsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSWAFByteMatchSets.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSWAFByteMatchSets.new(test: 'dummy') }
  end
end

class AWSWAFByteMatchSetsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_byte_match_sets
    mock_data = {}
    mock_data[:byte_match_sets] = [{ byte_match_set_id: 'byte_match_set_id', name: 'name' }]
    data[:data] = mock_data
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFByteMatchSets.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_byte_match_set_exists
    assert @resp.exist?
  end

  def test_byte_match_set_ids
    assert_equal(@resp.byte_match_set_ids, ['byte_match_set_id'])
  end
end