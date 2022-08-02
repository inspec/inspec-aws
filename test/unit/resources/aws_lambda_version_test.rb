require 'helper'
require 'aws_lambda_version'
require 'aws-sdk-core'

class AWSLambdaVersionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSLambdaVersion.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLambdaVersion.new(layer_name: '', version_number: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLambdaVersion.new(unexpected: 9) }
  end
end

class AWSLambdaVersionSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_layer_version
    mock_data = {}
    mock_data[:content] = {
      location: 'test1',
      code_sha_256: 'test1',
      code_size: 1,
      signing_profile_version_arn: 'test1',
      signing_job_arn: 'test1',
    }
    mock_data[:layer_arn] = 'test1'
    mock_data[:layer_version_arn] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:version] = 1
    mock_data[:license_info] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaVersion.new(layer_name: 'test1', version_number: 1, client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_versions_exist
    assert @resp.exists?
  end

  def test_location
    assert_equal(@resp.content.location, 'test1')
  end

  def test_code_sha_256
    assert_equal(@resp.content.code_sha_256, 'test1')
  end

  def test_code_size
    assert_equal(@resp.content.code_size, 1)
  end

  def test_signing_profile_version_arn
    assert_equal(@resp.content.signing_profile_version_arn, 'test1')
  end

  def test_signing_job_arn
    assert_equal(@resp.content.signing_job_arn, 'test1')
  end

  def test_layer_arn
    assert_equal(@resp.layer_arn, 'test1')
  end

  def test_layer_version_arn
    assert_equal(@resp.layer_version_arn, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_version
    assert_equal(@resp.version, 1)
  end

  def test_license_info
    assert_equal(@resp.license_info, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end
