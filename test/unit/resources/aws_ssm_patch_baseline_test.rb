require 'helper'
require 'aws_synthetics_canary'
require 'aws-sdk-core'

class AWSSyntheticsCanaryConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSSyntheticsCanary.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSyntheticsCanary.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSyntheticsCanary.new(unexpected: 9) }
  end
end

class AWSSyntheticsCanarySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_canary
    mock_data = {}
    mock_data[:runtime_version] = 'test1'
    mock_data[:runtime_version] = 'test1'
    mock_data[:runtime_version] = 'test1'
    mock_data[:runtime_version] = 'test1'
    mock_data[:runtime_version] = 'test1'
    mock_data[:runtime_version] = 'test1'
    mock_data[:runtime_version] = 'test1'
    mock_data[:runtime_version] = 'test1'
    data[:data] = { canary: [mock_data] }
    data[:client] = Aws::SSM::Client
    @resp = AWSSyntheticsCanary.new(name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_canary_exist
    assert @resp.exists?
  end

  def test_id
    assert_equal(@resp.id, 'test1')
  end
end
