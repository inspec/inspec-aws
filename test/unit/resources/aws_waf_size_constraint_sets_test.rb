require 'helper'
require 'aws_waf_size_constraint_sets'
require 'aws-sdk-core'

class AWSWAFSizeConstraintSetsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSWAFSizeConstraintSets.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSWAFSizeConstraintSets.new(test: 'rubbish') }
  end
end

class AWSWAFSizeConstraintSetsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_size_constraint_sets
    mock_data = {}
    mock_data[:size_constraint_sets] = [{ size_constraint_set_id: 'size_constraint_set_id', name: 'name' }]
    data[:data] = mock_data
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFSizeConstraintSets.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_size_constraint_set_exists
    assert @resp.exist?
  end

  def test_size_constraint_set_ids
    assert_equal(@resp.size_constraint_set_ids, ['size_constraint_set_id'])
  end
end 