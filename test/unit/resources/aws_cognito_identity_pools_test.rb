require 'helper'
require 'aws_cognito_identity_pools'
require 'aws-sdk-core'

class AWSCognitoIdentityPoolsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCognitoIdentityPools.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCognitoIdentityPools.new('rubbish') }
  end

  def test_identity_pool_non_existing_for_empty_response
    refute AWSCognitoIdentityPools.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCognitoIdentityPoolsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_identity_pools
    mock_parameter = {}
    mock_parameter[:identity_pool_id] = 'test1'
    mock_parameter[:identity_pool_name] = 'test1'
    data[:data] = { :identity_pools => [mock_parameter] }
    data[:client] = Aws::CognitoIdentity::Client
    @identity_pools = AWSCognitoIdentityPools.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_identity_pools_exists
    assert @identity_pools.exist?
  end

  def test_identity_pool_ids
    assert_equal(@identity_pools.identity_pool_ids, ['test1'])
  end

  def test_identity_pool_names
    assert_equal(@identity_pools.identity_pool_names, ['test1'])
  end
end