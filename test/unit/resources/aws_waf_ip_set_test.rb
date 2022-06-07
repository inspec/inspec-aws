require 'helper'
require 'aws_waf_ip_set'
require 'aws-sdk-core'

class AWSWAFIPSetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSWAFIPSet.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSWAFIPSet.new('', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSWAFIPSet.new(unexpected: 9) }
  end
end

class AWSWAFIPSetHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_ip_set
    mock_data = {}
    mock_data[:ip_set_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:ip_set_descriptors] = [{ type: "test1", value: 'test1' }]
    data[:data] = { ip_set: mock_data }
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFIPSet.new(ip_set_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ip_set_exists
    assert @resp.exist?
  end

  def ip_set_id
    assert_equal(@resp.ip_set_id, 'test1')
  end

  def test_ip_set_name
    assert_equal(@resp.name, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end 