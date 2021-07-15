require 'helper'
require 'aws_cognito_userpool_clients'
require 'aws-sdk-core'

class AWSCognitoUserPoolClientsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCognitoUserPoolClients.new(user_pool_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCognitoUserPoolClients.new('rubbish') }
  end

  def test_identity_pool_non_existing_for_empty_response
    refute AWSCognitoUserPoolClients.new(user_pool_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSCognitoUserPoolClientsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_user_pool_clients
    mock_parameter = {}
    mock_parameter[:client_id] = 'test1'
    mock_parameter[:user_pool_id] = 'test1'
    mock_parameter[:client_name] = 'test1'
    data[:data] = { :user_pool_clients => [mock_parameter] }
    data[:client] = Aws::CognitoIdentityProvider::Client
    @user_pool_clients = AWSCognitoUserPoolClients.new(user_pool_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_user_pool_clients_exists
    assert @user_pool_clients.exist?
  end

  def test_client_ids
    assert_equal(@user_pool_clients.client_ids, ['test1'])
  end

  def test_user_pool_ids
    assert_equal(@user_pool_clients.user_pool_ids, ['test1'])
  end

  def test_client_names
    assert_equal(@user_pool_clients.client_names, ['test1'])
  end
end