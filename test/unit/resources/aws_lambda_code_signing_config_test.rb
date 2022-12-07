require 'helper'
require 'aws_lambda_code_signing_config'
require 'aws-sdk-core'

class AWSLambdaCodeSigningConfigConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSLambdaCodeSigningConfig.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLambdaCodeSigningConfig.new(code_signing_config_arn: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLambdaCodeSigningConfig.new(unexpected: 9) }
  end
end

class AWSLambdaCodeSigningConfigSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_code_signing_config
    mock_data = {}
    mock_data[:code_signing_config_id] = 'test1'
    mock_data[:code_signing_config_arn] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:allowed_publishers] = {
      signing_profile_version_arns: ['test1']
    }
    mock_data[:code_signing_policies] = {
      untrusted_artifact_on_deployment: 'test1'
    }
    mock_data[:last_modified] = Time.now
    data[:data] = { code_signing_config: mock_data }
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaCodeSigningConfig.new(code_signing_config_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_code_signing_configs_exist
    assert @resp.exists?
  end

  def test_code_signing_config_id
    assert_equal(@resp.code_signing_config_id, 'test1')
  end

  def test_code_signing_config_arn
    assert_equal(@resp.code_signing_config_arn, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end
