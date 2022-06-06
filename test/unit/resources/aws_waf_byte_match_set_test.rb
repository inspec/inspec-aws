require 'helper'
require 'aws_waf_byte_match_set'
require 'aws-sdk-core'

class AWSWAFByteMatchSetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSWAFByteMatchSet.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSWAFByteMatchSet.new('', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSWAFByteMatchSet.new(unexpected: 9) }
  end
end

class AWSWAFByteMatchSetHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_byte_match_set
    mock_data = {}
    mock_data[:byte_match_set_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:byte_match_tuples] = [{ target_string: "test1", field_to_match: { type: 'test1', data: 'test1'}, text_transformation: 'test1', positional_constraint: 'test1' }]
    data[:data] = { byte_match_set: mock_data }
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFByteMatchSet.new(byte_match_set_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_byte_match_set_exists
    assert @resp.exist?
  end

  def byte_match_set_id
    assert_equal(@resp.byte_match_set_id, 'test1')
  end

  def test_byte_match_set_name
    assert_equal(@resp.name, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end