require 'helper'
require 'aws_ssm_patch_baselines'
require 'aws-sdk-core'

class AWSSESPatchBaselinesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSSESPatchBaselines.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSSESPatchBaselines.new('rubbish') }
  end

  def test_baselines_non_existing_for_empty_response
    refute AWSSESPatchBaselines.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSSESPatchBaselinesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_patch_baselines
    mock_data = {}
    mock_data[:baseline_id] = 'test1'
    mock_data[:baseline_name] = 'test1'
    mock_data[:operating_system] = 'test1'
    mock_data[:baseline_description] = 'test1'
    mock_data[:default_baseline] = true
    data[:data] = { :baseline_identities => [mock_data]}
    data[:client] = Aws::SSM::Client
    @resp = AWSSESPatchBaselines.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_baselines_exists
    assert @resp.exist?
  end

  def test_baseline_ids
    assert_equal(@resp.baseline_ids, ['test1'])
  end

  def test_baseline_names
    assert_equal(@resp.baseline_names, ['test1'])
  end

  def test_operating_systems
    assert_equal(@resp.operating_systems, ['test1'])
  end

  def test_baseline_descriptions
    assert_equal(@resp.baseline_descriptions, ['test1'])
  end

  def test_default_baselines
    assert_equal(@resp.default_baselines, [true])
  end
end