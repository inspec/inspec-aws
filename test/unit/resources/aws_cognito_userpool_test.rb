require 'helper'
require 'aws_cognito_userpool'
require 'aws-sdk-core'

class AWSCognitoUserPoolConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCognitoUserPool.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCognitoUserPool.new(identity_pool_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCognitoUserPool.new(unexpected: 9) }
  end
end

class AWSCognitoUserPoolSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_user_pool
    mock_parameter = {}
    mock_parameter[:id] = 'test1'
    mock_parameter[:name] = 'test1'
    data[:data] = { :user_pool => mock_parameter }
    data[:client] = Aws::CognitoIdentityProvider::Client
    @res = AWSCognitoUserPool.new(user_pool_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_user_pool_exists
    assert @res.exists?
  end

  def test_id
    assert_equal(@res.id, 'test1')
  end

  def test_name
    assert_equal(@res.name, 'test1')
  end

  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, 'test1')
  end
end