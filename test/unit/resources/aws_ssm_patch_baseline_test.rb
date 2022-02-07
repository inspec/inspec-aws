require 'helper'
require 'aws_ssm_patch_baseline'
require 'aws-sdk-core'

class AWSSESPatchBaselineConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSSESPatchBaseline.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSESPatchBaseline.new(baseline_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSESPatchBaseline.new(unexpected: 9) }
  end
end

class AWSSESPatchBaselineSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_patch_baseline
    mock_data = {}
    mock_data[:baseline_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:operating_system] = 'test1'
    mock_data[:description] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::SSM::Client
    @resp = AWSSESPatchBaseline.new(baseline_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_baseline_exist
    assert @resp.exists?
  end

  def test_baseline_id
    assert_equal(@resp.baseline_id, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_operating_system
    assert_equal(@resp.operating_system, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end
end
