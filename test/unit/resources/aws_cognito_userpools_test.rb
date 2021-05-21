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

  def test_user_pool_non_existing_for_empty_response
    refute AWSCognitoUserPools.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCognitoUserPoolsHappyPathTest < Minitest::Test

#   def setup
#     data = {}
#     data[:method] = :list_identity_pools
#     mock_parameter = {}
#     mock_parameter[:id] = 'test1'
#     mock_parameter[:name] = 'test1'
#     mock_parameter[:status] = 'test1'
#     # mock_parameter[:last_modified_date] = 'test1'
#     # mock_parameter[:creation_date] = 'test1'
#     data[:data] = { :identity_pools => [mock_parameter] }
#     data[:client] = Aws::CognitoIdentity::Client
#     @identity_pools = AWSCognitoUserPools.new( client_args: { stub_responses: true }, stub_data: [data])
#   end

#   def test_identity_pools_exists
#     assert @identity_pools.exist?
#   end

#   def test_ids
#     assert_equal(@identity_pools.ids, ['test1'])
#   end

#   def test_names
#     assert_equal(@identity_pools.names, ['test1'])
#   end

#   def test_statuses
#     assert_equal(@identity_pools.statuses, ['test1'])
#   end

#   def test_last_modified_dates
#     assert_equal(@identity_pools.last_modified_dates, ['test1'])
#   end

#   def test_creation_dates
#     assert_equal(@identity_pools.creation_dates, ['test1'])
#   end
end