require 'helper'
require 'aws_waf_ip_sets'
require 'aws-sdk-core'

class AWSWAFIPSetsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSWAFIPSets.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSWAFIPSets.new(test: 'rubbish') }
  end
end

class AWSWAFIPSetsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_ip_sets
    mock_data = {}
    mock_data[:ip_sets] = [{ ip_set_id: 'ip_set_id', name: 'name' }]
    data[:data] = mock_data
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFIPSets.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ip_set_exists
    assert @resp.exist?
  end

  def test_ip_set_ids
    assert_equal(@resp.ip_set_ids, ['ip_set_id'])
  end
end 