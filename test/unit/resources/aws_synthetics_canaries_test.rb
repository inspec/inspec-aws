require 'helper'
require 'aws_synthetics_canaries'
require 'aws-sdk-core'

class AWSSyntheticsCanariesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSSyntheticsCanaries.new(client_args: { stub_responses: true })
  end

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSyntheticsCanaries.new(unexpected: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSyntheticsCanaries.new(unexpected: 9) }
  end
end

class AWSSyntheticsCanariesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_canaries
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:artifact_s3_location] = 'test1'
    mock_data[:engine_arn] = 'test1'
    mock_data[:runtime_version] = 'test1'
    data[:data] = { canaries: [mock_data] }
    data[:client] = Aws::Synthetics::Client
    @resp = AWSSyntheticsCanaries.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_canaries_exist
    assert @resp.exists?
  end

  def test_ids
    assert_equal(@resp.ids, ['test1'])
  end

  def test_names
    assert_equal(@resp.names, ['test1'])
  end

  def test_artifact_s3_locations
    assert_equal(@resp.artifact_s3_locations, ['test1'])
  end

  def test_engine_arns
    assert_equal(@resp.engine_arns, ['test1'])
  end

  def test_runtime_versions
    assert_equal(@resp.runtime_versions, ['test1'])
  end
end