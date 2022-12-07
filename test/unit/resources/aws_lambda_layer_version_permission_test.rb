require 'helper'
require 'aws_lambda_layer_version_permission'
require 'aws-sdk-core'

class AWSLambdaLayerVersionPermissionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSLambdaLayerVersionPermission.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLambdaLayerVersionPermission.new(layer_name: '', version_number: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLambdaLayerVersionPermission.new(unexpected: 9) }
  end
end

class AWSLambdaLayerVersionPermissionSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_layer_version_policy
    mock_data = {}
    mock_data[:policy] = 'test1'
    mock_data[:revision_id] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaLayerVersionPermission.new(layer_name: 'test1', version_number: 1, client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_layer_version_policy_exists
    assert @resp.exists?
  end

  def test_policy
    assert_equal(@resp.policy, 'test1')
  end

  def test_revision_id
    assert_equal(@resp.revision_id, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end