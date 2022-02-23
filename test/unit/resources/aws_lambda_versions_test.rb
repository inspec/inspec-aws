require 'helper'
require 'aws_lambda_versions'
require 'aws-sdk-core'

class AWSLambdaVersionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSLambdaVersions.new(layer_name: 'test1', client_args: { stub_responses: true })
  end

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLambdaVersions.new(unexpected: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLambdaVersions.new(unexpected: 9) }
  end
end

class AWSLambdaVersionsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_layer_versions
    mock_data = {}
    mock_data[:layer_version_arn] = 'test1'
    mock_data[:version] = 1
    mock_data[:description] = 'test1'
    mock_data[:created_date] = Time.now
    mock_data[:compatible_runtimes] = []
    mock_data[:license_info] = 'test1'
    mock_data[:compatible_architectures] = []
    data[:data] = { layer_versions: [mock_data] }
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaVersions.new(layer_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_layer_versions_exist
    assert @resp.exists?
  end

  def test_layer_version_arns
    assert_equal(@resp.layer_version_arns, ['test1'])
  end

  def test_versions
    assert_equal(@resp.versions, [1])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def test_license_infos
    assert_equal(@resp.license_infos, ['test1'])
  end
end