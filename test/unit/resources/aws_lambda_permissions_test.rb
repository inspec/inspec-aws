require 'helper'
require 'aws_lambda_permissions'
require 'aws-sdk-core'

class AWSLambdaPermissionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSLambdaPermissions.new(function_name: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSLambdaPermissions.new('rubbish') }
  end

  def test_functions_non_existing_for_empty_response
    refute AWSLambdaPermissions.new(function_name: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSLambdaPermissionsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_policy
    mock_data = {}
    mock_data[:sid] = 'test1'
    mock_data[:effect] = 'test1'
    mock_data[:principal] = 'test1'
    mock_data[:action] = 'test1'
    mock_data[:resource] = 'test1'
    data[:data] = mock_data
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaPermissions.new(function_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_sids
    assert_equal(@resp.sids, ['test1'])
  end

  def test_effects
    assert_equal(@resp.effects, ['test1'])
  end

  def test_principals
    assert_equal(@resp.principals, ['test1'])
  end

  def test_actions
    assert_equal(@resp.actions, ['test1'])
  end

  def test_resources
    assert_equal(@resp.resources, ['test1'])
  end
end