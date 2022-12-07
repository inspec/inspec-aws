require 'helper'
require 'aws_cognito_userpool_client'
require 'aws-sdk-core'

class AWSCognitoUserPoolClientConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCognitoUserPoolClient.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCognitoUserPoolClient.new(identity_pool_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCognitoUserPoolClient.new(unexpected: 9) }
  end
end

class AWSCognitoUserPoolClientSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_user_pool_client
    mock_parameter = {}
    mock_parameter[:user_pool_id] = 'test1'
    mock_parameter[:client_name] = 'test1'
    mock_parameter[:client_id] = 'test1'
    mock_parameter[:client_secret] = 'test1'
    mock_parameter[:refresh_token_validity] = 1
    mock_parameter[:access_token_validity] = 1
    mock_parameter[:id_token_validity] = 1
    mock_parameter[:read_attributes] = ['test1']
    mock_parameter[:write_attributes] = ['test1']
    mock_parameter[:explicit_auth_flows] = ['test1']
    mock_parameter[:supported_identity_providers] = ['test1']
    mock_parameter[:callback_urls] = ['test1']
    mock_parameter[:logout_urls] = ['test1']
    mock_parameter[:default_redirect_uri] = 'test1'
    mock_parameter[:allowed_o_auth_flows] = ['test1']
    mock_parameter[:allowed_o_auth_scopes] = ['test1']
    mock_parameter[:allowed_o_auth_flows_user_pool_client] = true
    mock_parameter[:prevent_user_existence_errors] = 'test1'
    data[:data] = { user_pool_client: mock_parameter }
    data[:client] = Aws::CognitoIdentityProvider::Client
    @user_pool_client = AWSCognitoUserPoolClient.new(user_pool_id: 'test1', client_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_user_pool_client_exists
    assert @user_pool_client.exists?
  end

  def test_user_pool_id
    assert_equal(@user_pool_client.user_pool_id, 'test1')
  end

  def test_client_name
    assert_equal(@user_pool_client.client_name, 'test1')
  end

  def test_client_id
    assert_equal(@user_pool_client.client_id, 'test1')
  end

  def test_client_secret
    assert_equal(@user_pool_client.client_secret, 'test1')
  end

  def test_refresh_token_validity
    assert_equal(@user_pool_client.refresh_token_validity, 1)
  end

  def test_access_token_validity
    assert_equal(@user_pool_client.access_token_validity, 1)
  end

  def test_id_token_validity
    assert_equal(@user_pool_client.id_token_validity, 1)
  end

  def test_read_attributes
    assert_equal(@user_pool_client.read_attributes, ['test1'])
  end

  def test_write_attributes
    assert_equal(@user_pool_client.write_attributes, ['test1'])
  end

  def test_explicit_auth_flows
    assert_equal(@user_pool_client.explicit_auth_flows, ['test1'])
  end

  def test_supported_identity_providers
    assert_equal(@user_pool_client.supported_identity_providers, ['test1'])
  end

  def test_callback_urls
    assert_equal(@user_pool_client.callback_urls, ['test1'])
  end

  def test_logout_urls
    assert_equal(@user_pool_client.logout_urls, ['test1'])
  end

  def test_default_redirect_uri
    assert_equal(@user_pool_client.default_redirect_uri, 'test1')
  end

  def test_allowed_o_auth_flows
    assert_equal(@user_pool_client.allowed_o_auth_flows, ['test1'])
  end

  def test_allowed_o_auth_scopes
    assert_equal(@user_pool_client.allowed_o_auth_scopes, ['test1'])
  end

  def test_allowed_o_auth_flows_user_pool_client
    assert_equal(@user_pool_client.allowed_o_auth_flows_user_pool_client, true)
  end

  def test_prevent_user_existence_errors
    assert_equal(@user_pool_client.prevent_user_existence_errors, 'test1')
  end

  def test_resource_id
    refute_nil(@user_pool_client.resource_id)
    assert_equal(@user_pool_client.resource_id, 'test1')
  end
end