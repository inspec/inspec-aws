require 'helper'
require 'aws_cognito_userpools'
require 'aws-sdk-core'

class AWSCognitoUserPoolsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCognitoUserPools.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCognitoUserPools.new('rubbish') }
  end

  def test_identity_pool_non_existing_for_empty_response
    refute AWSCognitoUserPools.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCognitoUserPoolsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_user_pools
    mock_parameter = {}
    mock_parameter[:id] = 'test1'
    mock_parameter[:name] = 'test1'
    data[:data] = { :user_pools => [mock_parameter] }
    data[:client] = Aws::CognitoIdentityProvider::Client
    @user_pools = AWSCognitoUserPools.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_user_pools_exists
    assert @user_pools.exist?
  end

  def test_user_pools_ids
    assert_equal(@user_pools.ids, ['test1'])
  end

  def test_user_pools_names
    assert_equal(@user_pools.names, ['test1'])
  end
end