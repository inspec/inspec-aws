require 'helper'
require 'aws_cognito_identity_pool'
require 'aws-sdk-core'

class AWSCognitoIdentityPoolConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCognitoIdentityPool.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCognitoIdentityPool.new(identity_pool_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCognitoIdentityPool.new(unexpected: 9) }
  end
end

class AWSCognitoIdentityPoolSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_identity_pool
    mock_parameter = {}
    mock_parameter[:identity_pool_id] = 'test1'
    mock_parameter[:identity_pool_name] = 'test1'
    mock_parameter[:allow_unauthenticated_identities] = true
    mock_parameter[:allow_classic_flow] = true
    mock_parameter[:developer_provider_name] = 'test1'
    mock_parameter[:open_id_connect_provider_arns] = ['test1']
    mock_parameter[:saml_provider_arns] = ['test1']
    data[:data] = [mock_parameter]
    data[:client] = Aws::CognitoIdentity::Client
    @identity_pool = AWSCognitoIdentityPool.new(identity_pool_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_identity_pool_exists
    assert @identity_pool.exists?
  end

  def test_identity_pool_id
    assert_equal(@identity_pool.identity_pool_id, 'test1')
  end

  def test_identity_pool_name
    assert_equal(@identity_pool.identity_pool_name, 'test1')
  end

  def test_allow_unauthenticated_identities
    assert_equal(@identity_pool.allow_unauthenticated_identities, true)
  end

  def test_allow_classic_flow
    assert_equal(@identity_pool.allow_classic_flow, true)
  end

  def test_developer_provider_name
    assert_equal(@identity_pool.developer_provider_name, 'test1')
  end
end