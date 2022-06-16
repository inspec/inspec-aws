require 'helper'
require 'aws_waf_size_constraint_set'
require 'aws-sdk-core'

class AWSWAFSizeConstraintSetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSWAFSizeConstraintSet.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSWAFSizeConstraintSet.new('', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSWAFSizeConstraintSet.new(unexpected: 9) }
  end
end

class AWSWAFSizeConstraintSetHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_size_constraint_set
    mock_data = {}
    mock_data[:size_constraint_set_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:size_constraints] = [{ field_to_match: { type: "test1", data: "test1" }, text_transformation: 'test1', comparison_operator: "test1", size: 1 }]
    data[:data] = { size_constraint_set: mock_data }
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFSizeConstraintSet.new(size_constraint_set_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_size_constraint_set_exists
    assert @resp.exist?
  end

  def size_constraint_set_id
    assert_equal(@resp.size_constraint_set_id, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end